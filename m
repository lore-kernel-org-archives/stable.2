Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121749;
	b=pKcDjcVPweoz4guXDyRMGYaaPgYvVv4DWZ23OyojiJITibVXWC11aTnT5WoicLZsmjOS
	 UHPqAqQYFNf1XFlm+JuGDYljR1bjjc8zm7+iN+YR84V7khDKQwHM+N8nR+vA5L9qcOggV
	 KFyFExHqPNza3S7oWlf8FC8y4/WeOW+nz51gV3WIDnFbz6Jv/x8j4BvOm/Ni+Fo5NTceb
	 PzpLIr57tGb0D/6Byrqw55CPunopscu+iP6+Y9hM/J+uZIzbxwuxK2hIci0rNYFTU/bDf
	 zI75C/EhGfm4rIJDq18OqGaFatVtg+kEsbaHQEM7U+eDuf/zjtwQO5EpJx+beG7Qibg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121749;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=VmFIuhYfP2v45XhFsesPKtjzFx6PdLailA1+NFQsFxc=;
	b=SDS0aDZzXPjX4L8ZPzn9zVqT58g7CJjFlGp9OvsJVSs9Bf9DVwHKa4ccQE2x6Gfk/ZZr
	 7650S3vPMk55w2BOZYkcvvhijfDpNSUxldd7jaOD1h1imTdbFwyLMoqwIi3u0Tet+Lcet
	 WDSXlOjyy8NHqwnXDqRnOlMz96QU64Tt7UTeJbNOUQq3UfLyHjP7bDzZ9ZGXKe1DqhTN8
	 Yp/Q3u699c+IjoazWh+ZkYlzMKQNQGGsLq0YYibWlPFEnyfcNUbMuSCsu2S3DnOL37uR8
	 2F8QJ5yve4iaC/3EOwrgzgQg6AutlVw0HO1pl8B1D/hr4EONrETETmxrvn+eTSzQaNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfYJbHsg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491A7606A320;
	Thu, 19 Nov 2026 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfYJbHsg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEB31F000C0;
	Thu, 19 Nov 2026 20:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121748;
	bh=VmFIuhYfP2v45XhFsesPKtjzFx6PdLailA1+NFQsFxc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=bfYJbHsg7ayESzygWUmQpu8CReYiL28GmUFbYPdLGqbcshAsXGweYjDSb2F5rLY45
	 kU+Q4NbL81lZ5NStlB8eMEsCXBcWSIEAXTf477Q0sfFYgWSJducvXDEePKEvTmN924
	 B3w9eRkrDv7SteU4nKu6H2R8XK0nXQuHYxlCoI96gUJJjeX2FudV07ansgmkxZEEPR
	 /yD/apNSH+hIxuztRsqO+RUrCTvcWfNoEVXV/UhFaLWq1cSbcO5Ci6Gj3DmyVOBPp7
	 I6nbr+qvKVb5tYhBfRU1OazG/II4Qa4kEvGqG7iSFHf7ojE5v6A7wgZAKOC3TpPDDT
	 BoIcd7pKsSqZA==
Date: Thu, 19 Nov 2026 21:55:46 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Krish Gulati <krishgulati7@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    syzbot+bc537ca7a0efe33988eb@syzkaller.appspotmail.com, 
    stable@vger.kernel.org
Subject: Re: [PATCH] HID: core: serialize report_descriptor_read() against
 probe and remove
In-Reply-To: <20261010095211.12831-1-krishgulati7@gmail.com>
Message-ID: <578s4770-23p5-78qs-9po9-49oq2sprsos8@xreary.bet>
References: <20261010095211.12831-1-krishgulati7@gmail.com>
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

On Sat, 10 Oct 2026, Krish Gulati wrote:

> Since commit 54f32fd5dff9 ("HID: Make report_descriptor available for
> all devices"), the "report_descriptor" sysfs attribute is part of the
> device's attribute group, so it exists from device_add() until
> device_del(). It reads hdev->rdesc, but that buffer only lives from
> hid_open_report() until hid_close_report(), that is, for the duration
> of a driver binding. For a driver with a report_fixup() callback,
> rdesc is a private copy that hid_close_report() frees, so a read that
> races with the driver being unbound accesses freed memory. syzbot
> reports this as:
> 
>   BUG: KASAN: slab-use-after-free in report_descriptor_read+0xb5/0x100
>   Read of size 24 at addr ffff888078d61f00 by task fido_id/7281
>   ...
>   Allocated by task 10:
>    kmemdup_noprof+0x2b/0x70
>    hid_open_report+0x1fa/0xf00
>    lg_probe+0x29c/0x890
>    hid_device_probe+0x46a/0x870
>    ...
> 
> Because hid_close_report() also clears rdesc and rsize, the same missing
> serialization can make the reader see a NULL rdesc with a non-zero
> rsize.
> 
> Hold the device lock in report_descriptor_read(). The driver core
> already holds it across probe and remove, so a read can no longer
> overlap with them.
> 
> Reported-by: syzbot+bc537ca7a0efe33988eb@syzkaller.appspotmail.com
> Tested-by: syzbot+bc537ca7a0efe33988eb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=bc537ca7a0efe33988eb
> Fixes: 54f32fd5dff9 ("HID: Make report_descriptor available for all devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Krish Gulati <krishgulati7@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

