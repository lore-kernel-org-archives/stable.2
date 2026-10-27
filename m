Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.205.69.214
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089917;
	b=3AyJjMpjkItnMAwbSKrH3zH6KP6wiNyCj7XogRh5jzvnbTQMoi/Min8Utg9cdGh3DgTy
	 9FqmGIODEry/6M+BaFqlgLd5y5qC7jxSreWgQdPM6nxTZ4ovlu6EhS4ra1GNvzGwNJtAA
	 ZXNaseED3o4nd9VKn7iOz/ko7ZbpmLHG2H+/CEArxIQktW9Ek2VkVkj5+slsMG/SnAbT2
	 +ThvV6Hjxp5RLNjugLBZ2j0AZY5E3LmqA7YOvYj+26wJms0Vzf9s/XlKHEErojAEqvXyi
	 7R2hw28yMWyeU7h1t4anG6ByDLZzxZuqNC5TNcOfPoFNwo2p/C6gvpTfhJAB3vMqDkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089917;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Message-ID:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Feedback-ID;
	bh=C+vkxyU67zeMcKwQ1EK2nacMQDWtW7hAmQ/dpae/8Nc=;
	b=14XQ+HDC1pela1pOAYlPhwNB0U4wAAljY7d8CAwh5oYuP9jCiFaXw0VEEd2QwniAQzDi
	 U0OmysYcRpQkvjO4A3FhKl68C1untblFIT0HQA2aJ4nzlQTa7yctqM4jC3w5W8GdQWAcO
	 PLc1mRP3JDi4+0Lj/dY1fvH9yTL2N0ja6vzs56F7PKfwqrh8bG7EiMhhXoXjcuWtjPoC2
	 fjrHFCw8BXlPqzzyQ7ztwNS9KMVH/zR8U215wGhQj4gXaxKhVBJnbVjckzqygBnCF6EIg
	 lQbld0FrQqGGUqf7KV0uLYismP7zx0MtMsEvJi1XXyEKrKLl9Fx9geGWdPubvueivjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tuta.io;
	spf=pass smtp.mailfrom=tuta.io;
	dkim=pass header.d=tuta.io header.i=@tuta.io header.a=rsa-sha256 header.s=s1 header.b=1fVdC8uS;
	arc=none smtp.remote-ip=185.205.69.214
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE04606A327
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 08:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BE04606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuta.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tuta.io header.i=@tuta.io header.a=rsa-sha256 header.s=s1 header.b=1fVdC8uS
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id D020819D206F0
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:31:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793089915;
	s=s1; d=tuta.io;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
	bh=C+vkxyU67zeMcKwQ1EK2nacMQDWtW7hAmQ/dpae/8Nc=;
	b=1fVdC8uSvxRplZYoxPCMM2VzmVJvp8Ayml4xvbBTROZ5YDWPWCcefGplVhfbuv8f
	LlOdbmrMZm1bGSP7DkNT8kOR8lfMIk0THHNbnnzVi+Tst254XO0tI3hiU8f2FUWfA4C
	3YXSdKws03ewH1Nrd3pQEDFo1WBMuIUmXaedOmjY9ydFXKtOua2uC2ZYCNiqkge97Ku
	SL5NQlLcXxUaNy2qz8B2WRy4r2OKlC4LyKDnvVcsNA+wPi4kvPE3qblW6VChlyA35+M
	VRvhXhNLIB7nsnroJ9teNnYPYgwafR1FE/g5R2UQ9XbaHbqsR0icBwEf4loWCRSabbK
	7lI3ZW233g==
Date: Tue, 27 Oct 2026 09:31:55 +0100 (CET)
From: Edvard Conrad <edvard@tuta.io>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Edvard Conrad <edvard@tuta.io>, Miklos Szeredi <miklos@szeredi.hu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Message-ID: <P4wUBaI--F-9@tuta.io>
Subject: Re: [PATCH] backing-file: inherit FMODE_NONOTIFY from the user file
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
Content-Transfer-Encoding: 7bit
Feedback-ID: 0127f977f5e13e8051b46c6e7f57d0f95a0470d24b79d7c31d07fdf611cc427ab823e0f4692a810119c92d8768973a9281:TurnOnPrivacy!:tutamail

On Tue, Oct 27, 2026 at 12:53 AM Amir Goldstein <amir73il@gmail.com> wrote:
> Any chance you can post this as an LTP test?

Yes. Written and verified, I will post it to the LTP list shortly as
syscalls/fanotify26. Two cases: a mark on the overlay only, which passes
on every kernel and keeps the test from passing for the wrong reason,
and a mark on the overlay plus the backing filesystem, which is the
shape that deadlocks.

> Urgh I hate how special case this is.
>
> How about something like below (untested)

Agreed on the shape, and it covers backing_tmpfile_open() as well, which
mine did not. As posted it does not fix the deadlock though:

> -       f->f_mode       = OPEN_FMODE(flags);
> +       f->f_mode       = OPEN_FMODE(flags) | fmode;

Five lines further down init_file() calls

	file_set_fsnotify_mode(f, FMODE_NONOTIFY_PERM);

and that helper clears FMODE_FSNOTIFY_MASK before it sets its argument,
so the inherited FMODE_NONOTIFY is dropped again. The backing file ends
up at FMODE_NONOTIFY_PERM, which is not FMODE_FSNOTIFY_NONE(), so
fsnotify_open_perm_and_set_mode() does not take its early return and
still raises FS_OPEN_PERM on the real path.

Measured in a VM on a defconfig + OVERLAY_FS + FANOTIFY +
FANOTIFY_ACCESS_PERMISSIONS build of this tree, with the reproducer from
the patch and with the LTP test:

  kernel                        reproducer    fanotify26
  mainline                      hangs         1 pass 1 fail
  v1 (fs/backing-file.c)        ok            2 pass
  your diff as posted           hangs         1 pass 1 fail
  v2                            ok            2 pass

v2 keeps your structure and routes the fsnotify part through
file_set_fsnotify_mode() instead:

	fmode_t fsnotify_mode = fmode & FMODE_FSNOTIFY_MASK;
	...
	f->f_mode	= OPEN_FMODE(flags) | fmode;
	file_set_fsnotify_mode(f, fsnotify_mode ? fsnotify_mode :
						  FMODE_NONOTIFY_PERM);

One deliberate difference from your version: it inherits only the "no
events at all" mode rather than masking FMODE_NONOTIFY out of whatever
the user file carries. A user file in the HSM mode (FMODE_NONOTIFY |
FMODE_NONOTIFY_PERM) would otherwise leave its backing file fully
silent, suppressing the events on real files that bc2473c90fca
deliberately enabled.

v2 follows in this thread.

Thanks,
Edvard
