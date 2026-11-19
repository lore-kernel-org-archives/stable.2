Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795122893;
	b=zQvYka3Zk5PD2tYFzLcoPVvu/6TTRrq3Q1FMMN/Dv8Urp2Wd6TX82xtvct1qk0W6jKqb
	 1s1JeY4UXidw/3LXMWriyIxxd6vOXEjsVpyyXum0r525weWEiGPYIQYF7KUU77CL2VnZE
	 2t1rEn7EuIqiikhHwcQAnKce6WCp/AHnezK9TZix/ge1/TABB/0hoMcuSlVi5Qmf6KtZ0
	 JlALYQMHutvdHfUyoBd6sz7pmHEMrrvEMQhg7ZTBFJC9WUa5s4ha7Mv6D/ThPmneIWnuE
	 xGvtIi27f4iKAOPDTpxg4qRd5+MpuDNVRTXYa7uaE19b8vVdbu0PyVqDEghqejA4tzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122893;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=vYYYorz+cZ58m91YhfS+Si8tK666WrlVnfvwVckDI2M=;
	b=Hswnbeuv/DotBVf7KEk/GMohR2o/LEbfCVsuREEo9J8BBh7g6SZeFzn4Fkt/2wl96GXY
	 zvhBMRVkgBLPCLBEbmZFuMp6Ja7cFG7W2nD4+FcyKU92E8hyoomqHBi7+2lCBqDiqwDeL
	 sTq3PDxsU60r62EtJAJ7m/nGQRQLcMwHZ0Zgl45H/6X9KbD6rGum+G+qAtdhM030aQ0lr
	 hzq6gyjZTBwtlQgF/5STh6HiTQ8A8fThQ+iN7eVUJGEu8wX+iK55p1FydAcbv1sTdl/bC
	 LsVSmQyHZQSEzHuN5pePvwcFjjiDn1cQOpoWSNYVu7CaW6hJonWnZBYK00h/+u3eIVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDf5lvkS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88E8606A320;
	Thu, 19 Nov 2026 21:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDf5lvkS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A577C1F000C0;
	Thu, 19 Nov 2026 21:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795122893;
	bh=vYYYorz+cZ58m91YhfS+Si8tK666WrlVnfvwVckDI2M=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=DDf5lvkSext3cSoCtwRQbCIqRgccgn+UDR7qQaeWro2qrL5U536Dhjn6mP27GFrA2
	 +FcGimcXhfGVo6X9zOXFNzVoZjGrlvA2pKe2UQ48tloEWSW1Lm9ImCV5Ct9DUNrR82
	 j81Pbh0syQxwJiisEeuNQWZSiXUIyZQm6Gff5slHCZctTEPTJn2hUtgcXO9ukFsyfO
	 FzlJPxv30agFk0f8Vee5mlpMMvbYAJKtrnqtQO5hXvRpIwiWO1o/FzJesGs4X9cwDZ
	 wlPESuPO4SJFBxLpLshAZG8DlV8lrXaBWBjM44fhg0maTcDVLpJ8wJPqpYcI19mxQf
	 0sIhDSeywQ//Q==
Date: Thu, 19 Nov 2026 22:14:49 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Gideon Heinz <gideonheinz02@gmail.com>, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
    Edwin Velds <e.velds@gmail.com>, 
    Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
    Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 00/33] HID: logitech-hidpp: G920 force-feedback fixes,
 rework, and cleanups
In-Reply-To: <av9mLqY8TMOhJK2-@google.com>
Message-ID: <n50o4sn6-s12o-7q3s-6q1o-s9p3o57s2285@xreary.bet>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com> <p6p98p0s-5p97-q584-14sn-ns404p6s3orn@xreary.bet> <49nqon1r-32pr-19r1-0r65-50494sq350n5@xreary.bet> <sr340r82-n378-035n-78ns-nrq4p808r3pp@xreary.bet> <av9lbJa8VlQTeatR@google.com>
 <av9mLqY8TMOhJK2-@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 19 Nov 2026, Dmitry Torokhov wrote:

> Oops, sorry, I forgot there were couple of Sashiko comments. Let's me
> send out the updated series (I already made changes earlier).

OK, I am moving v2 out of sight, thanks.

While you're at it, if you can send it as two separate series (fixes for 
7.4 and improvements for 7.5), that'd be appreciated.

-- 
Jiri Kosina
SUSE Labs

