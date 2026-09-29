Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752F75172E3;
	Tue, 29 Sep 2026 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683730; cv=none; b=uINU87GFuxUO+f/VLIh94Ouagr+sDeNwwucZDLu8omYDbDYw5ebMDvdE53gG+QWIqXqcQqHDpa3YuIKZfgaGar0k9VOtvbYpXgx1DCnZ8NSdr8isB4WsmmbE5/UZ1fNeBLLtlcDctQKUpYxhm7MrKzMQzbY5bveaThDw2jOXmCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683730; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D8UFlty1mvDCPktu/PlzU/e/65bshuwjJgbdKWBvrnBkOF8Bft9B4BznMKn5CqnVQ645m0kkMOn35rkFoP7FXxxznsR/+NQaOCSi8trXAI2lm1BvMua9+9neA9UXlWdOVMGhDTsWjmE7vvjtb44bH63RfQVcvhGrjkK7Zc6n3LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCiFkXLh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCiFkXLh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A3F1F000FF;
	Tue, 29 Sep 2026 12:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790683729;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kCiFkXLhQKyNv/5Npt6GxQ6y/fvhK7QAXn3t77gsH8H7DB/NKWfzqWrXfBOOBiQwL
	 O3aacWVK8qVSzY14AmmC2vP3jDbN4EtWl3xe9R6F7Sdd3LPXl2QboBA8tV2VKur4BJ
	 RGNvP4FLYi+9lITJZzPMzvn4jyLBvkUwC81pslZYi4TTjzjxxxvodIHHCexPaDrFP8
	 rCbGfXyuPffBLw6si6/FpJYK/a3z0QHm0l4AqqGpaMECLiCVoIsQURLpQDfHtcBUmh
	 1lVZd3x8w16LuJZDLDqMg+N7WHoWM0SZuzMSQrJaOGYu/lkvO9uujOrUsvzPcxPj4E
	 RNr6g9il7MoAA==
From: netdev-bot+sinfo@kernel.org
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, jiayuan.chen@linux.dev,
 Hyunwoo Kim <imv4bel@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2] strparser: make sure __strp_recv isn't running
 before tearing down the parser
Date: Tue, 29 Sep 2026 12:08:48 +0000
Message-ID: <179068372824.31693.4401867477449994158@kernel.org>
In-Reply-To: 
 <f06217a9b95b7027286c7df21336e67e334c3e6e.1790674872.git.sd@queasysnail.net>
References: 
 <f06217a9b95b7027286c7df21336e67e334c3e6e.1790674872.git.sd@queasysnail.net>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
