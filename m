Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E8A31326A;
	Thu, 23 Jul 2026 23:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784848595; cv=none; b=GFZv6trUSs/p5Wr3nkw4SXenq/JMZzOjzSxo1qeoaYAcnFlJO/fl4kOKdjiTVjoJTUc9591eLu28dxNdOo2opKWOUHqbw7X2dyeIPCQU4ZpKdn1zy/v+m4ZNVlz2z15kH2y/WPrpN4Gh5nBpZm6hzFZC2WZep6kdiYu9SAM6TXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784848595; c=relaxed/simple;
	bh=l0EOcT3Hj7HEparH1m0NIreWB3lwI6hn15Ukpic1zpI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=N09HXYrQPjgN/aj0nnCTyvyKjceLLLUq0mjwmIShIMl9ix3UHu8I5c7lmP1LVT7iUQiMfh+JNTUtLTpAarKu4J3h+kn3IvMEl8tAsUUyFbu9SGmAMmB0B8xFBBGM2WqN54AugI3lizWp+H1foqkF1N5sx13uYk1ozu8ODh+yswE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MR5HHJSL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MR5HHJSL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A8F1F000E9;
	Thu, 23 Jul 2026 23:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784848594;
	bh=nxvDNRcaEJb/ntcgfZBTPV3yUhwk30rTipu7armknUU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=MR5HHJSL7qYPuAUy3Fed38sunopaq3XOz5pWQh0fruilynxBtCCcFTPHmCjbhDyDE
	 ceLFD25phB+/QWtIn6Kldjg6ukks/TvBwlr1fG40/0EqRxeczyeR8jYRk8CwMrsbkH
	 N2WEu3IzMZbcrO+5v3aulL19YbiWAhyAC7OmqcLq4TYelnBQ/0B/8sBMMGhq0073/m
	 07O5JSiMQBW3WWjGPkL+AE1w7DX/TvAv2uCvF3Waw3qBdyCXowQucYCkHfP0n8YAWW
	 kC/Vufcb3exeGj2uDvie3K2etmRE3IG3uvsiNMIhkJCtq4VwdzsPwOlWGL/lFDmLfY
	 nasEqGJsGxnxw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH RESEND] kbuild: Stop modifying $(objtree)/Makefile when
 building oot-kmods oos
From: Nathan Chancellor <nathan@kernel.org>
To: Nicolas Schier <nsc@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Anish Rashinkar <rashinkar.anish@gmail.com>, stable@vger.kernel.org, 
 Philipp Hahn <p.hahn@avm.de>, Nicolas Schier <n.schier@fritz.com>
In-Reply-To: <20260723105845.1704689-2-nsc@kernel.org>
References: <20260723105845.1704689-2-nsc@kernel.org>
Date: Thu, 23 Jul 2026 16:16:22 -0700
Message-Id: <178484858201.4095280.2018856728416028444.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1904; i=nathan@kernel.org;
 h=from:subject:message-id; bh=l0EOcT3Hj7HEparH1m0NIreWB3lwI6hn15Ukpic1zpI=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFlJC853bl4RsnV/9flHDbwLXLlsjisfsv/+wDVL//rFZ
 9MPyghVdJSyMIhxMciKKbJUP1Y9bmg45yzjjVOTYOawMoEMYeDiFICJVEUzMny7aMnGrbJPdt7J
 +7N91GdUas9i7r5b2hX/uvCeYh7/okmMDL0rzhjuUi77lRcqfUXYcd7Npb0/dS4kZT22PmHBe6N
 XkREA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

> Update output Makefile in the corresponding tree only: for out-of-source
> in-tree builds update $(objtree)/Makefile, for out-of-source out-of-tree
> module builds update $(KBUILD_EXTMOD_OUTPUT)/Makefile instead.
> 
> In-source builds are not affected.
> 
> Since commit c9bb03ac2c66 ("kbuild: reduce output spam when building out
> of tree"), building out-of-tree kernel modules out-of-source (make M=...
> MO=...) causes a rewrite of $(objtree)/Makefile with KBUILD_EXTMOD and
> KBUILD_EXTMOD_OUTPUT being set.  That is problematic:
> 
>  * $(objtree)/ must not be changed in any way when building out-of-tree
>    modules as it breaks other uses of $(objtree).
> 
>  * Setting KBUILD_EXTMOD and KBUILD_EXTMOD_OUTPUT in $(objtree)/Makefile
>    kills the tree for incremental builds that start right there
>    ('make -C $(objtree)'); builds starting in $(srctree) reset
>    $(objtree)/Makefile to its original content.
> 
> Further, $(KBUILD_EXTMOD_OUTPUT)/Makefile was not generated any more at
> all.
> 
> This commit restores the previous kbuild behaviour prior to commit
> c9bb03ac2c66 ("kbuild: reduce output spam when building out of tree")
> but leaves in-place the use of filechk for output spam reduction.
> 
> Fixes: c9bb03ac2c66 ("kbuild: reduce output spam when building out of tree")
> Reported-by: Anish Rashinkar <rashinkar.anish@gmail.com>
> Closes: https://lore.kernel.org/r/CAOESE2Q2-0KUDaM0mUo+c_F-tMaUsBZ-gpnhdoe0rmYdgnnuJQ@mail.gmail.com
> Cc: stable@vger.kernel.org
> Tested-by: Philipp Hahn <p.hahn@avm.de>
> Reviewed-by: Philipp Hahn <p.hahn@avm.de>
> Signed-off-by: Nicolas Schier <n.schier@fritz.com>
> Signed-off-by: Nicolas Schier <nsc@kernel.org>

Thanks!

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

Do you want me to take this via kbuild-fixes?

-- 
Cheers,
Nathan

