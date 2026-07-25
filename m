Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDA01A3029
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 01:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784942027; cv=none; b=cfq6aiaBnrv6hWb0A5ngiXqx6YgOcdoihFv2gNH5/0U5biQcatl23pVTNnuuXUvbQ8sqlTjBsibsOUO8ToGtOtXOCBZkh/ck6xud54jwc3a3nfNOVQtgn3ArRX2kuLTHwBQJg/Tr2nYmllDwc334uX2yfnTaPxlq8Ns8aZ3hmVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784942027; c=relaxed/simple;
	bh=pNiW3WBCzJLx3UPL3XoTNpv9DHkcvgdWFYbzKEOL1OU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hl1FEBnqDpz3KqjIvJeRY/jyJK5BOaGsMvfprggQRL8t2k0GCBxtx+mpXq9gJbAd53FYDbMzMG8+eFCk9gW9KMEL9NO72BkV5BfRVTj4XDxxVcvrtDE28PaFWDEKAdo4WM7eKGSCGAlFJuLI3S7qLRIFw+G5hFUxAlr0zS73X84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzF2W+zS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzF2W+zS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174401F000E9;
	Sat, 25 Jul 2026 01:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784942026;
	bh=9m+6qBm5wzCc2o5QDMPRAgTsAOzpMpXRy/ic4yJR2i8=;
	h=Date:From:To:Cc:Subject;
	b=JzF2W+zSGPLP/pyX9YA5QX7f+ct7vSdTE4kZUIb42For1kM0/7fGDGXBmu+CcZ8F8
	 nugJ0m05gWmRHGR72uOlVASKx8VUTnb3NWIiT/3Sx7WaMfakes/qziFufG/Po3lkK4
	 hRmwvRDllPUG5ASzNABb19gTbYN72JJVW5WCzsHwp/U0nXlhEwi7t/pppe3re/yeAM
	 cZsIrQG9g13ju9jEcmyM/7fC6yXlMXrxmW7V8fa69Aw/q1I/R5nBfuLCSoypOtN/pb
	 Dfo4gEQDhn9sawdiHgyOrMPD2r1/dHxhtprNAE+dYufj1Ypu2u+28i1vb8NNhcby8M
	 yrZ+61vyY9Nvw==
Date: Fri, 24 Jul 2026 18:13:42 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
	Marcus Seyfarth <m.seyfarth@gmail.com>
Subject: Please apply 90dfeef1cd38 to 6.1 through 6.18
Message-ID: <20260725011342.GA2792705@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi stable folks,

Upstream commit cc39f3872c08 ("seqlock: Introduce
scoped_seqlock_read()") was backported in several stable branches (6.18
through 6.1) recently without a necessary fix, commit 90dfeef1cd38
("seqlock: Cure some more scoped_seqlock() optimization fails"),
breaking the build for certain configurations

  https://github.com/ClangBuiltLinux/linux/issues/2178

Please consider applying 90dfeef1cd38 to 6.18 through 6.1 to avoid this,
it applies cleanly to all those trees for me. You may also want to
consider taking

  b94d45b6bbb4 ("seqlock: Allow KASAN to fail optimizing")
  88331c4ec23a ("seqlock: Allow UBSAN_ALIGNMENT to fail optimizing")

but I did not test if they were clean cherry picks.

-- 
Cheers,
Nathan
