Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D163932E6
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701619; cv=none; b=nglgI4Xcc4zvGW3nQdmLlL0zFRakQMjwtXzaB6SiVFDHPrIWjo0S/wBG+CuLstRy5haJgYMlV/t8O2REJvaT/3HaEcAUAsPwO1Ynn95Rv4OZ6qcuLm5CNC1vdZNt/3yR6trULzgupXI7BT/85eXPPZUeve6QvlX68LWDBVA/SpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701619; c=relaxed/simple;
	bh=wOqs1rQlZi8DZ25m9tWV7HHHocg0HOiKwI71qIMFtnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eFT1usYzuC6oz00+lDN+YEAkgwW5gePBOn4f1tWQWE5rFSOcAVpr10lV387ZKMc29YREvsG+xjoTCu303eBpeIC27qlrB7++etAvd0VS/Qc3ydOBVvq5NGThswXQIAW6X9gSqBtoFA+u8nPD/jhorvum04encspFR0PTkEUMg4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpSS99Um; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpSS99Um"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41C11F00A3D;
	Sun,  6 Sep 2026 13:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701617;
	bh=3zvu88CItkHVA9nI3P3mOr5H6oyn/AnTyoW4qrerZOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SpSS99UmIR8K2Hk3zSF2eMWl26r7qucwE5kkXJhc3AQnCMcHVIt8MbNbp6qdqywpU
	 adPeK1OL2C0Tljyki4JvyDVq5itaJW3hdKfjhVgsBMdM0itn1CWEDHfNU10+EyrJA5
	 A/au582m2N2EEpVEf8FuS2b42in8PxBHmVteLdsoyWFeGDGjovjgoo2PrQJY/mX5bJ
	 YXej13aMGaSeKz7Bj0MhrMppgpFY9hbmNpVHIsE1jIN8Xo7/pB4o11oS+CRBnEFlZd
	 ++cKXn97ZWEdQNsbfrfidFpZaCKIBhawMne8wy7+rMi6qr6aZuKMitR1RqQSIpwW4z
	 tL0FeeZMYXeMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [PATCH 6.6.y 0/2] Backport 'openvswitch: Fix CT limit teardown use-after-free'
Date: Sun,  6 Sep 2026 09:32:43 -0400
Message-ID: <2026-09-05-daily-reply-0013-ovs-ct-limit-uaf-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904093840.1815273-1-i.maximets@ovn.org>
References: <20260904093840.1815273-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The patch doesn't apply well without the previous kernel-doc fix.
> It seems cleaner to backport both instead of modifying the main patch.
>
> Ilya Maximets (1):
>   net: openvswitch: fix kernel-doc warnings in internal headers
>
> Yuqi Xu (1):

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha
