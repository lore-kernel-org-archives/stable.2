Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4399735F189
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 01:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783992317; cv=none; b=Nqth7cVzl6OZSIgCEMkmag73nzpTQFEROH10Bzu4Gm7X3ByZEIPhadRWOJBK82p317E4KF/kQBZOSMVtMJLWXrZszZRgVVyuFG0/qTkJGTNQ0m+rcfzQ5BbUq4sofpIx2Icwtz9msZbfVJlptz8mmrCYBs0zo9VAUKkqeNpUvyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783992317; c=relaxed/simple;
	bh=2lO2BnUENBZy+RyvknQ3ZmGUwLalQq1KBkM3ahjvHeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OqKb+47V8kh8HNXc7Y1kMHoyNieQjgPQHVV0cudpCyCEhY2bnT+HHvGJJflBfJlQ4Q+hkr/hqjKfDVGy4H6k2eiGEOxHJEeCBNJ5ZtFhTZBoTvODna919wKTpEiC7UElfK0jy+dhgTvm0fNo3V3fydL3YI37YMutWabZAppitpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZCb3x/Yg; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZCb3x/Yg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783992313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FR/ogQyOUb61rBJdQJ3QLZfWszhyR9KWxGTeTHElZ4I=;
	b=ZCb3x/YgW/I5mWxpII+Vx9dGwpvsZMaLb/HPt3V2OcuigN8Mz3nH+8FbeOz4DGDWgUbyxZ
	j/26L03UZ7eE6hD8+6yskEaboMVUqD4CB9UpU5mBiCVa8PEwSXwpwuDUszsnGKbeVEP6cG
	RNLVTBh8+k1LJVu2O5Dalcr1PePjLGQ=
From: Tao Cui <cui.tao@linux.dev>
To: zhaotianrui@loongson.cn,
	maobibo@loongson.cn,
	chenhuacai@kernel.org
Cc: kernel@xen0n.name,
	lixianglai@loongson.cn,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 0/2] LoongArch: KVM: EIOINTC: fix INT_ENCODE ipnum out-of-bounds access
Date: Tue, 14 Jul 2026 09:24:50 +0800
Message-ID: <20260714012452.1021833-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tao Cui <cuitao@kylinos.cn>

This small series fixes a guest-triggerable out-of-bounds access in the
LoongArch KVM EIOINTC emulation, then factors the duplicated IP-number
decode into a helper.

The IP-number decode in eiointc_set_sw_coreisr() and eiointc_update_irq()
bounds ipnum only in the default (1-hot) mode. In INT_ENCODE mode the raw
ipmap byte (0..255) is used to index sw_coreisr[cpu][ipnum], whose second
dimension is LOONGSON_IP_NUM (8), so any ipmap byte >= 8 reads/writes past
the array. The value is guest-programmable through the EIOINTC virtual
extension (VIRT_CONFIG enables INT_ENCODE and the IPMAP IOCSR write is not
validated) and is also restored from a migration stream via the
LOAD_FINISHED control attribute, so this is a host slab out-of-bounds
access reachable from an unprivileged guest.

Patch 1 is the minimal, stable-bound fix: clamp ipnum to [0, LOONGSON_IP_NUM)
in INT_ENCODE mode at both call sites. Patch 2 is a follow-up cleanup that
extracts the now-identical decode into eiointc_get_ipnum() (no functional
change); it is split out so the fix stays surgical for backporting.

Verified with KASAN on Loongson-3A6000: the device-attr restore sequence
(INT_ENCODE + ipmap byte 0x80 + LOAD_FINISHED) reports
"BUG: KASAN: slab-out-of-bounds in eiointc_set_sw_coreisr" without the
series and is clean with it.

Patch 1 carries Fixes:/Cc: stable; patch 2 is mainline-only.

Tao Cui (2):
  LoongArch: KVM: EIOINTC: clamp ipnum to valid range in INT_ENCODE mode
  LoongArch: KVM: EIOINTC: factor IP-number decode into a helper

 arch/loongarch/kvm/intc/eiointc.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

--
2.43.0
