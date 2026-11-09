Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.218
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229271;
	b=ejODD76+ZQRpK/Hd8c2gbFqh3RVIwmzFHJq+Dt08v+kET6UfPt+P1MTXdyd7WlNYIHgM
	 t2rG29ona8uPAziPM8HdClRHmViw9+pnm+3OAaspQum2A3iujlb0Yf5Nv3ju9SLDj2aAq
	 O7EciEtPcYW7F3BN88K965STp0MjidCi6kSJE+HQtZgbiemyzZ4xfF/qLfjnxv1A6xXrW
	 p+e+ETraE04IHGDU6TrLkt6UPL9gLLbVzoyq9FykY9YEp2T8O0bdroVVuMHyqV0zDCqqU
	 ARXVgAu+m6AGCHscWM+YKg+DKEupNSJiAAUBXuNr2wLRKArSDL1InKKG8yLPHt/8jtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229271;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Date:Message-ID;
	bh=E1GGOvtBlaTsUmYtmvnwqkByifPIkOREx0MBTWn/Tmk=;
	b=5N8xKo20r3w5XulvnAYfUGtyMG/JYsKsH6XgTqM1bihQGzMQhKtqZT06DZr4z+Aq9sMn
	 pQwt8BhfMSYs41Unaw0xkLSid05kAISuBxB5VMWo52zpuBlneX8N+9ntQMSNEvMHwGzzq
	 268J0piGCDHSmiD6U14J+TMlcC34Ss2f2/c793HchjnC8yVjAYSQ1ovls0wOp1eU/qLqj
	 N1zbeUvOCi2qcrZpc9Ntuu/w7O2BctygUQDeohAR2hXmXFQbBJPC85nwIw28dV4DAq/Cp
	 Gs4I2S5skM3ip9mroiBjJS0oeg/hQusNRGN1b8bfF/ID0i1fan/1qe5Ceq2X32z3fsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=cRi9kA5s;
	arc=none smtp.remote-ip=115.124.28.218
Received: from out28-218.mail.aliyun.com (out28-218.mail.aliyun.com [115.124.28.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA96606A321;
	Mon,  9 Nov 2026 13:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FA96606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=cRi9kA5s
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794229260; h=From:To:Subject:MIME-Version:Content-Type:Date:Message-ID;
	bh=E1GGOvtBlaTsUmYtmvnwqkByifPIkOREx0MBTWn/Tmk=;
	b=cRi9kA5sFS6J+a7FaRlbDo68s5P7YCoHdnukMM2Ee5hS+12hixfHA/J0V3F/L3gL3Dskx5B7KRmEkpf/G0XK4iL7KTt8LulY7bX9sC3LMuS5JStdE9t0NKpK9jAcuXeLHrMLEmd7eLk+IeN6l4jfPWNadLVgm6t39RQNFU/qNWQ=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2289389|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0211135-0.00440467-0.974482;FP=13103200845358019423|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037026024;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.k-FCRfd_1794229257;
Received: from 127.0.0.1(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.k-FCRfd_1794229257 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 21:00:58 +0800
From: Weibin Liu <liuwb@xiaopeng.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>,
 Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Steven Chen <chenste@linux.microsoft.com>,
 stable@vger.kernel.org,
 Zhu Guanglei <zhugl3@xiaopeng.com>
Subject: Re: [PATCH v2] ima: fix races when deleting measurement list entries
In-Reply-To: <95b47e1a0a30022ede9f52ce0e80b0f957097b5b.camel@huaweicloud.com>
References: <20261109123335.432186-1-liuwb@xiaopeng.com>
 <95b47e1a0a30022ede9f52ce0e80b0f957097b5b.camel@huaweicloud.com>
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
Date: Mon, 09 Nov 2026 21:00:57 +0800
Message-ID: <179422925743.761920.15976497107095793440@xiaopeng.com>

On Mon, 2026-11-09 at 13:49 +0100, Roberto Sassu wrote:
> Is it still true with the new semaphore?

No. That paragraph describes the unpatched code. The patch serializes
writers with ima_measurements_rwsem and protects the lookup and cut
with ima_extend_list_mutex.
