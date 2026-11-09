Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794212377;
	b=dIaP0gISf4SW/t+G9jKX2lHdU+YWAzbsWe/xTDxTyFlYh9O8LT1FcsMwu7qdUCCk74I8
	 zNiF9Q3IllPWeKtxoIsaSLKxUxSP+3FsQKIXccPc50OEdhvxL3lMrJXD119+EIniAAy3j
	 zSIULdJimUW02pCZLC2MYkG9YawNSKzK/0XBiiE4Yvpoyy7Qt0Aw4Eszl4A4hIHXsKoa4
	 iO7OkEl8/8coZ1pIvqpWzfhjwjQFkAiOiTROxs+gHhNoKuZX1AltLRC5F+Z7jbmWsxDCM
	 F4Y9sLG/zfRUTqt6lFk2d3EfaDuunZgCMWBh+nbx8yHvLKe1mSILSfTEWNdBYhUbsdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212377;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=LwiRrHuIEM0c1RECgB7tHJ1By6bIMEOUkcyx0I4tC7Q=;
	b=kKEMJgoUOSOPfT3ML4uUhwjk6OF7EFbRu8pCb+WDAMlijbYRKL4Dl9L2qXmMbLm9AdBu
	 d4+LzT9srWiY2/xBXofxqWLLq8a7lZBYUSl0QuJ3LnVVtqNwhXoIOkSxQ1bfj4tG0kU0X
	 t/VM89ZS5UBkIEoISq83B5JY9cAHWI33HWvapSWZgNIRyJ8HuhgAODw+w2GxZKE9tJh7O
	 HArwpV/Y7nMGnWM/xM5DEQjnOUDoWobE5Yt+whsweP0M1TXtqbmfqXU+DNC42QIo/p3oq
	 EE2HOhDHMmz8pKHR/3eVhztqfSKCNdx4khrpnShQeh+MgqrGj8H0dL59CjGcgAaC28w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=modelmiser.com;
	spf=pass smtp.mailfrom=modelmiser.com;
	dkim=pass header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=Rvu7HsMc;
	arc=none smtp.remote-ip=79.135.106.116
Received: from mail-106116.protonmail.ch (mail-106116.protonmail.ch [79.135.106.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7D0606A323;
	Mon,  9 Nov 2026 08:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D7D0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=Rvu7HsMc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=modelmiser.com;
	s=protonmail; t=1794212372; x=1794471572;
	bh=LwiRrHuIEM0c1RECgB7tHJ1By6bIMEOUkcyx0I4tC7Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Rvu7HsMcsBPUNAiQJxAM4L+nyEsn0eQA0pNlRHeH38LqJdKWonaet/Vfd048BGExv
	 7vpIg7dblK1Z3RnuSJmZtN+RAXpiSAkO0rdjaSFTsFveOVsAZIimLE4wHkFg5bXXAL
	 RCGY3QtCE/JLyYLOyRwS3dA0qi4/xdPayiTc2kyc/ekGCXBB6di/GCu4yRfbJMpThP
	 WdvRO1wu5Y2ihlda6n1X5uFwRZpGNH+FZ91pY+NuoBHqb0LANwooff/B4l7zexSHhn
	 7+xuyz0YtQKc/gg+te9LEQKLnbNkGk1CxwayMVo0Jya9jcFJP7p7ngDiNSXIkE/E5r
	 5KUtP2xWp7r+w==
Date: Mon, 09 Nov 2026 08:19:25 +0000
To: =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Hans de Goede <hansg@kernel.org>, =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
From: Chad Aldreda <ca@modelmiser.com>
Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>, platform-driver-x86@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: dell-smo8800: keep the state until the last file is closed
Message-ID: <20261109081921.276450-2-ca@modelmiser.com>
In-Reply-To: <20261107204950.88952-2-ca@modelmiser.com>
References: <20261107204950.88952-2-ca@modelmiser.com>
Feedback-ID: 232753253:user:proton
X-Pm-Message-ID: 154141c3edacb5656cd161da6802610911c441b6
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Shuangpeng Bai reported this bug in June, with a reproducer, and I missed
the report when I sent this patch. It is the same use-after-free after an
unbind with the file still open.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Closes: https://lore.kernel.org/all/178144969601.60470.2802762361760676957@=
gmail.com/

Chad

