Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84658136358
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 00:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781138746; cv=none; b=NOgNTxrxP3HGSpy5y7A2wWxICU2Z1mXAVVdffZGCGG3q33rLHP6j8or0e6XCMvsL3LtluXCmOQcYTaWtBqNSVth7QNepdlbCmCkpd2kKYTD+MuiNflutGBeOAYCxb8GsO2OUCHEyWgEaK/TJ78+YQGp8er3cQiwZUzdjIy3brDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781138746; c=relaxed/simple;
	bh=VN1XsT/xl3GZnuqFo8/wCtNL6c8hYIoCPkohEyG3xfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMGZjZvng4C/jBUfkFd19M2pGf37bGl3Im0JayhjlGHdAwcYMEWANJJ215+uO/9+8Uo6YreyNs+Qaivr4YrwtyVb1JpcSNGFtIVsEztjN4kXCIYh4llbmKuXSMzBeuYtsHp6rBwM+cnih6yofo0DLue+y/LebA8q/afaOJkQeGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8voCih0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8voCih0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAB81F0089B;
	Thu, 11 Jun 2026 00:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781138744;
	bh=VN1XsT/xl3GZnuqFo8/wCtNL6c8hYIoCPkohEyG3xfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L8voCih0mytZHTH4gYZ1w7iKevQkQX+4M9/Ivh5MMr9D7FBDZ3E92vbJ2dVmxiAhz
	 Ae9JBA7VZg8RpS97psxFYfNl1CLqupsMS0d20uc/z17Ga/6ADwY8jW8xMxY3So2tv9
	 NS/PUNywtwtkooYi8KmZsaC5kVt9et9YT8utycdTkxM6mIo1FkE5mUEzHKrq8ms38M
	 lVxV/p+86grNM3jgWKK1O0i/AZ7f5Vi4eAW75YcHyfoayPu5xvtr2/4UVUCL+59LNw
	 CSqP9RbpYPTtXlPcWVqSaNUTPgr+kcwD3ozrq3RvjRXNhtmRDHAR4T/wSqqcRSNBxR
	 Fw0IXYOV5ouew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Minh Nguyen <minhnguyen.080505@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: Please apply 98d0912e9f84 ("net: skbuff: fix missing zerocopy reference in pskb_carve helpers") to 6.1.y
Date: Wed, 10 Jun 2026 20:45:25 -0400
Message-ID: <20260610-stable-reply-0009@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aihmk7GjOP0e0miV@eldamar.lan>
References: <aihmk7GjOP0e0miV@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jun 09, 2026 at 09:16:35PM +0200, Salvatore Bonaccorso wrote:
> Please apply 98d0912e9f84 ("net: skbuff: fix missing zerocopy
> reference in pskb_carve helpers") to 6.1.y

Agreed this is needed. It's already queued in the newer trees (7.0,
6.18 and 6.12 all carry it), but 6.6, 6.1, 5.15 and 5.10 are all
affected and still missing it.

--
Thanks,
Sasha
