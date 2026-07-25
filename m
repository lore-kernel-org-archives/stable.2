Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82750EAC7;
	Sat, 25 Jul 2026 00:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784940565; cv=none; b=HXxwaqpWieA/fsTP+zjthBrJuL1ffxQM4yX6Ris5Fz8f9/7RlbAubWe9ELJznipwIz+roEFY4slKihZI/mihXs8Dtv3op+1pye0Zz2PoDFkDiPW1DqbDpWG8dQLK8w8eVItXlOMH5KwPcSDk9dE2OHqZF1tzktouSycOaOwSY30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784940565; c=relaxed/simple;
	bh=3A+zQSBEdZ32Y61uoOfrcZrwNjTrw0AXt/s5Z4tAuZc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tOvA2IEb/MG2I5emZ6ijvxhtqDUf94kZszdWe7k3pziWgPkiyyp19Ztm7TovQaABJG/Ko8Yiwy6WbKamsb15ExuwCOjnpShfy8dcM1NbfOrgC0HEpRCcQZ88qcdrVy40DA1+VwdRfrw9B3RHAUQlJolNFuVYVbpPDx92pcMY41Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxIJLeR8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxIJLeR8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4BB1F000E9;
	Sat, 25 Jul 2026 00:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784940564;
	bh=Ho6TtOrPZyNBP3E/KYY18YTZwyThWZiPvdkdX0l7kyA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=oxIJLeR8EukAtnEI5RS/OqkTdffuyy2mmzjXF9muNIGEfg6+0ciZkWe9nWRmjiBt8
	 eulcQMX9OFA7L7NCILf1on74ZE7QodiV62UFUUHAAiTsWRdZ5FFH64efzX36pbEJu+
	 fnk7UDYEktsJtNQxNhAa0jEZZu+U5g4dTfw0J+enrb4dTMYz49VICvtVqg4Q0Nurhz
	 +YftOVEAPYpzMv4EMGOi+R+EuLVkONoMJcDkQpoDYgygeXnYGYtZSURPiz0G0X0qCs
	 UogS3SNPTEtKTSCQguiV2Is6YwX1eLR3FcjAbKFCTfIeqxCGurKvzMippsau2Q7aAt
	 dpRCq0OkNoSRA==
From: Nathan Chancellor <nathan@kernel.org>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Nicolas Schier <nsc@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Anish Rashinkar <rashinkar.anish@gmail.com>, stable@vger.kernel.org, 
 Philipp Hahn <p.hahn@avm.de>, Nicolas Schier <n.schier@fritz.com>
In-Reply-To: <20260723105845.1704689-2-nsc@kernel.org>
References: <20260723105845.1704689-2-nsc@kernel.org>
Subject: Re: [PATCH RESEND] kbuild: Stop modifying $(objtree)/Makefile when
 building oot-kmods oos
Message-Id: <178494055091.1465780.2245176294213657802.b4-ty@b4>
Date: Fri, 24 Jul 2026 17:49:10 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=768; i=nathan@kernel.org;
 h=from:subject:message-id; bh=3A+zQSBEdZ32Y61uoOfrcZrwNjTrw0AXt/s5Z4tAuZc=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFkpHEKHelsjlDcJ3i55c4tVr4+z7E37v/Mrt+3fIv009
 VEU0/IJHaUsDGJcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAiZ5cx/FN5EZln8eiflnH0
 wuPGjFpHrh9dr3Fn8tmLgstmButOOr6SkeG7dovQ2iXOkpbH/qce7opf0PN+7QqnhQ4Loj9ypey
 2KWYCAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

On Thu, 23 Jul 2026 12:58:45 +0200, Nicolas Schier wrote:
> kbuild: Stop modifying $(objtree)/Makefile when building oot-kmods oos

Applied to

  https://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git kbuild-fixes-unstable

Thanks!

[1/1] kbuild: Stop modifying $(objtree)/Makefile when building oot-kmods oos
      https://git.kernel.org/kbuild/c/39d6e68f50f4a

Please look out for regression or issue reports or other follow up
comments, as they may result in the patch/series getting dropped or
reverted. Patches applied to an "unstable" branch are accepted pending
wider testing in -next and any post-commit review; they will generally
be moved to the main branch in a week if no issues are found.

Best regards,
-- 
Cheers,
Nathan


