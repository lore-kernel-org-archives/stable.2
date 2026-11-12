Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487984;
	b=sUp8W2XdGDJ+1mY/tdBsXhDM+J7YG+UwY9qO18Gk0/iXIu/dIiWxLWMkVKybsHphlp8F
	 26ge1VllHLQ25Z/coyazBOgXPfQqTd5eNkgw7NUdbfV42WxjY/HtvXvmyC+vNSdSlZXww
	 q6MxI1+haTNapCcxLo0qOQm44EYmHD4Bcq1BWCu+xOVF3PDTZV6qwpfmAWVj9bLxWFpo0
	 WeQiJV2a0CibvuYfQ9v8d8qgXeeIVsRvZv9w24SRwQHAIOGXM2y6hkikWvBroPJo7hKHU
	 D/DGkRd0ucFRULDacRk9w+DiELdW3wSnh30PG/V/g5vljHcc3d52cmetaGSr00nvELw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487984;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=yX/L1x4ZGZXTilXb62Za88zoxS/rAl+itZPKFnz9f2E=;
	b=dtUGcXJeLb5SKTH1Gv/UIJuQQkjhoJhGjjJGa6LqQW7TaBCEyNAyDdbT5tBRIQiuOt4Q
	 b6dKrMkdj2UXHG0M0ctytkUDiV+utTiU5JHR0KDNsIFZ4hfZsd6bsgWm4qwVpOHK/O2EG
	 aLdZ88k2w2RXb/kbOErwpcbmwoMLcPcMJX8ftynmNsxx6guzZ5qgSw/Jy3dcDT7K0GJ2G
	 uJROz9Ce1oW+u4gGdDsEFaro4xReeTDXLgiQZPTugnvgnjaZKs8WFcNNyvoykSSB09NYK
	 4bdiIAXRLG+Qgk/8OwSzC+MuwC5iXHbevLQNi1W19JK6R+VUm7xN5ACMpxOrQw426CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=SQmozrjb;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFBA606A32E;
	Thu, 12 Nov 2026 12:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AFBA606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=SQmozrjb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=yX/L1x4ZGZXTilXb62Za88zoxS/rAl+itZPKFnz9f2E=; b=SQmozrjb+tJVVe8WL8GEdZ4sYg
	gR3uXOb0qznPCASCyqeO4KUGyqh9c7ezNkKEYwDnQrcY6nyoIdC8CHg1MNDjRtHMaepoDSauZfqKq
	xbaQaFV8bdl/d/op5bC2rHBwKKVdWMyUHwpLzGPRBjPTVy+s09wD/0Qqvrphn1+2rQSIOy7hKy6ZC
	BpqSr3M2e5hDqUcE/JoDNKM7sHqthj5UteJc6DqhoVOuJq5RFd2dJsUi6KzjQkQhV9o7FF7uYe5In
	K73r26ZMk/kRkaTm8SG5TPOiJueuQOWrdVYTIp5wOMyDDohZTStWu3Cz3VdBjDYBCoFj1hBqXsKGZ
	I/xtjRyQ==;
Received: from [151.115.150.205] (port=38878 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xRUIZ-00000003H1G-2a6p;
	Thu, 12 Nov 2026 13:53:01 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] kexec_file: update IMA after machine post-load
Date: Thu, 12 Nov 2026 12:52:45 +0000
Message-ID: <20261112125246.2715174-3-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261112125246.2715174-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261112125246.2715174-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

ima_kexec_post_load() replaces the global IMA mapping with a mapping for
the new image. If machine_kexec_post_load() fails, the new image is
freed but that mapping remains. The installed image no longer receives
the execute-time IMA update, and the notifier can write the
measurement list into freed pages.

Call the machine hook first. Return its error before updating IMA so IMA
changes the mapping only for an image which will be installed.

Fixes: 9f0ec4b16f2b ("ima: kexec: move IMA log copy from kexec load to execute")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 kernel/kexec_file.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index b668ce8d68ee..59f9ba1b0cd7 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -206,11 +206,17 @@ kimage_validate_signature(struct kimage *image)
 
 static int kexec_post_load(struct kimage *image, unsigned long flags)
 {
+	int ret;
+
+	ret = machine_kexec_post_load(image);
+	if (ret)
+		return ret;
+
 #ifdef CONFIG_IMA_KEXEC
 	if (!(flags & KEXEC_FILE_ON_CRASH))
 		ima_kexec_post_load(image);
 #endif
-	return machine_kexec_post_load(image);
+	return 0;
 }
 
 /*
