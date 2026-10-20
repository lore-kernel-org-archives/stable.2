Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502971;
	b=n9VCMdA61voW9AT8Nkc1MS6pSpmuV3yf0iGrLiSgMm5WG1/C8UR1x0h4HEmF8BvKV7lc
	 cSjnCyeTaFnOY0qCw++uhAQ+L8OXm8MnqLC5c61EjFL/Z/c8mjG/j5F7ZTNC4tN/zgbVh
	 dhYtkLaRw5bo0IEFBFoDlYgjNb+7wwD22c4eUiZ+iBuif/e61AnwxSd46FrjKbkLoBPIv
	 1c/npNUOXgXJDYT7rBOtuhxWBlfsJ5ivLTtNBOw0mdvnp+hIWJw5FeUIDnv5r1LW/cvW3
	 KekxXLRtQdYdOSFmjh9PITVPnpk6cLDb1FjMrhiITDJfkK9QOTPZc552vADTc6FMTfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502971;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hM+QEoi1JNt5tNwKnk3qY5QT2eSGNCwRsdv4CdlCerk=;
	b=3mqbPMPnKNPyEEtUUyBTp17PNv9jnbjJBmq8Qni4e4TV2TznL69Z1p9CVH8Rc6DYJk1X
	 rav6n/u4ZvzD101jqBL1HH4ZWJcLQamTkeCn6leDoQkp4gJP5MA6/EutWs89UPVMw6onG
	 YHFwwYqYoBgRqyUTqc/WIy00qqIYhccIEayl5p1Ea8VaPJAXdJoxq5XtCdfgJfVuVdevE
	 mR4HYhT4GltihHBLVP6gtZDF/bulNn/ultzDFWIvR+jKwTEB9YWzMBFL2+61ixSUtQXOG
	 v2+ENBcYdVdYUX1FYbmnmnlzuYIE3Q6a4rp1qro2Wbpon8hvVMcO5HG91wn7Y3oYbsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CrBTN5D2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FBA606A31C;
	Tue, 20 Oct 2026 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CrBTN5D2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151B11F000C5;
	Tue, 20 Oct 2026 13:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792502971;
	bh=hM+QEoi1JNt5tNwKnk3qY5QT2eSGNCwRsdv4CdlCerk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CrBTN5D2G6KM60kMBXONbLkThCc9IAxQ7svdwAzTLH1GmAP4bqYpxgbkq6NxU5PjZ
	 YyS1gx0udNNmEft5MjYmmm+1damjJF7PUuwOp13ARnMsGz1TbxDcmGSeGPQDYaoZSX
	 PGWZAZQEUr2EIlUfRRog6fYKjevebSf9k2EDlgvWKnufr9ZE9Bkj5xKWUZqiRq5kIU
	 ejTgKQnEKb2yMfY6MxnMNihMo0cJqRYtfeYulY30M3WzXUVDvKHISTAWQ75Q5L336F
	 CAZZGzqNFRT/YrpGPor6Jx2m9VOVpvUPIGAuK2ePBfjtaczbLw16bM9hkOluO6MxkW
	 vE0dWCqz3c4wg==
From: Sasha Levin <sashal@kernel.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: broonie@kernel.org,
	corbet@lwn.net,
	error27@gmail.com,
	geert@linux-m68k.org,
	gregkh@linuxfoundation.org,
	kees@kernel.org,
	konstantin@linuxfoundation.org,
	ksummit@lists.linux.dev,
	laurent.pinchart@ideasonboard.com,
	leon@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@leemhuis.info,
	mst@redhat.com,
	ojeda@kernel.org,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	tytso@mit.edu,
	workflows@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 3/7] docs: stable-kernel-rules: drop rules the stable trees do not apply
Date: Tue, 20 Oct 2026 09:29:27 -0400
Message-ID: <20261020132927.3149027-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <DF061D87-D1A3-42F6-AA3C-C288D3CB6BF3@mainlining.org>
References: <20261016152828.3765695-1-sashal@kernel.org> <20261016152828.3765695-4-sashal@kernel.org> <DF061D87-D1A3-42F6-AA3C-C288D3CB6BF3@mainlining.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 16, 2026 at 05:01:54PM +0100, Bradley Morgan wrote:
>On 16 October 2026 16:28:23 BST, Sasha Levin <sashal@kernel.org> wrote:
>>-- It must be obviously correct and tested.
>>-- It cannot be bigger than 100 lines, with context.
>>+- It must be correct and tested.
>
>s/tested/fully tested ?
>
>'Tested" to agents would be just a basic compile test, maybe we could
>define here what you want the agent to do?
>
>E.g: a W1? A QEMU repro? And others.

This rule applies to every stable patch, and the right testing differs a
lot between, say, a driver fix and an mm change, so I'd rather not pin it
down here. For agents, coding-assistants.rst already covers it: the fix
has to be checked with the reproducer or a full re-analysis, and the
agent has to say explicitly when it could not be built or tested.

>>   - No "trivial" fixes without benefit for users (spelling changes, whitespace
>>     cleanups, etc).
>
>What I tend to do when I use AI on my own projects to find bugs are to get
>it to "verify" what it finds to be a good enough bug. Could you refer to
>the security document here? That could help very well for AI agents to
>find proper bugs.

stable-kernel-rules.rst already points security fixes at
security-bugs.rst, and coding-assistants.rst has agents read
threat-model.rst to decide whether a bug is a vulnerability.

>Id also suggest that perhaps you *could* make a new patch saying that
>
>"When finding bugs, you need to verify that this bug is severe enough to
>need stable backporting or a CVE, if you reckon it is not severe enough
>for them, if it's not reproducible, eliminate the bug from the results"

I'd rather not. A bug that doesn't qualify for stable still needs a fix
in mainline, and many real bugs, races in particular, are hard to
reproduce; that is why this patch drops the "theoretical race" rule. CVEs
are assigned by the CVE team once a fix is in a stable tree, so the
finder doesn't need to decide that.

Confirming that a bug is real before reporting it is the part that
matters, and coding-assistants.rst already asks for a reproducer.

-- 
Thanks,
Sasha
