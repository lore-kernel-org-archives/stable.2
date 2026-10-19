Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [51.250.60.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6354B8270
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.60.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403598; cv=none; b=bI/jd4TWeOV9FWiSXaTIJ/KWr8i6nSWhJLyybcTlld362Ok27JjCWDJxkeDO05Nv6E/vUc3a0skodJQHPQupvqjuq2TWSwEaVddr/GavQRdlRfQUlTp3Jhfbe2/whlSNIl5WPohI0f8yiUldxPZ2MW2NMlZ1ByrW1lqHrA0moKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403598; c=relaxed/simple;
	bh=Dh7Z7awkBIIKdRBwTL1dNqrFIUqBUn5oYckoG/Bd2Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YhuLAMvDaOKU9tP4RywiG9gXMo5ghM1DVEa0hYcaft2/EgTYzcDopQIDdmvjqWBKziM/H2qvyLZWMzBVmhqasPSIr8s23oAi9/bJNooTZkVRrQJtQJuW+vE98XVuO0OkVAuA+aeKQsEVvD3uwtiJi+3Go6O56Svxd6ELh0fwsjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=JhJX5xly; arc=none smtp.client-ip=51.250.60.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="JhJX5xly"
Received: from mail-nwsmtp-smtp-production-main-36.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.yp-c.yandex.net)
	by forward103d.mail.yandex.net (postfix) with ESMTPS id F08ECC082A;
	Mon, 19 Oct 2026 12:53:06 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36 with ESMTPSA id 5rV6YbUhriE0-hsEinji3;
	Mon, 19 Oct 2026 12:53:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1792403586; bh=7Jj0Xdf1qyw8jmDqUXCVBgGOUPEqG1k4x/aMa4IbE40=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=JhJX5xlyydFoErZ5PtpmSH8jgfjh/Oe2zLcvWwc8QBXTP+CLhz2HtlqJRK1eDcett
	 BFPMGS5SzgYw6G73CDeFkacntwWHt2VnwO/tBch1jdEnQSpp4aRQ5HDb2o5DJfqxgj
	 EJDIAvz0+5HNdVr88jnNs76lPkJoq2zPnrCNmUpQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-36; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 6.12 v2 0/5] Fix crashes observed running BPF testsuite
Date: Mon, 19 Oct 2026 12:52:34 +0300
Message-ID: <20261019095239.221813-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is intended to fix kernel crashes observed
running tools/testing/selftests/bpf tests on 6.12.11{1,2}.

Dmitry Antipov (1):
  tcp_bpf: propagate error code in tcp_bpf_sendmsg()

Levi Zim (2):
  skmsg: Return copied bytes in sk_msg_memcopy_from_iter
  tcp_bpf: Fix copied value in tcp_bpf_sendmsg

Sami Tolvanen (2):
  selftests/bpf: Use the correct destructor kfunc type
  bpf, btf: Enforce destructor kfunc type with CFI

 kernel/bpf/btf.c                                      | 7 +++++++
 net/core/skmsg.c                                      | 5 +++--
 net/ipv4/tcp_bpf.c                                    | 9 +++++----
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 8 +++++++-
 4 files changed, 22 insertions(+), 7 deletions(-)

-- 
2.56.0

