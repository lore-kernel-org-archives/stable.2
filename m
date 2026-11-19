Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795124293;
	b=HK6Byom9A6ze1gkEZ7xFX/zQMP1AbnfWl1roNti+cpkQ1uHbubkbHWRkTugkNriLqGiC
	 EWMcWqpXahgCHwiMKDmZFw5f+pNuqCnkmnttaBH5yN4qib+8+9CHBC3GqVmOQDGTD4lSW
	 KwDTrnHol3jfg18vH4iIjzBPgqiye8SUel2Xlv2pJdUKXSzdMgcPf0cqcATKMvpaMzhdA
	 0A1NIO18ExH8BS/ffwZrDKqS/uJTi1Tc3koZ2soYucctXt+zMDFh2kNEjKKUgqamJfbxT
	 YvkV878t0QmPIHmsongooh1f6BPBlEh4TguIsynU5GmHjUiwopidOxyjg+NlWCw3ltA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795124293;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=PnTwqTAd6zPrVDdCBBgYNiAIBZrwMCrGj4srPVWYgRc=;
	b=SncmAP3iFi7IY8yF5hd/tO6ZMRwFqihZN8yw15Do5Mtlj9gH/LqUhnjm4q4r5IVH8cF2
	 nsfujC6wAZt6yrGlZs7nUK1qpZKkvt0RA/YuImM1bHHg2lfyDlcUSseYvgsB4ixdkDeyH
	 tJtE5iWx9iyRjwysX50bINPoIaKxx/tDVu0yyIgZR8y7GQjP8gNRJJAAp+ynGjRy6sW7c
	 ZIfdCT5WY/N3Yge5Joiv6JddaBBupij/gDaOl28haouueFkzcmPR8yV+DF2qU8Y4e0A9X
	 5+CPRwzhe4aHpJ8iyZSDd4zAymtMGj1DEoaPLLSXIyPd3BMEPrESIgW7CHbe7jaUiBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDll02Pn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5167606A320;
	Thu, 19 Nov 2026 21:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDll02Pn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB641F000C4;
	Thu, 19 Nov 2026 21:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795124292;
	bh=PnTwqTAd6zPrVDdCBBgYNiAIBZrwMCrGj4srPVWYgRc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=kDll02Pn+Thrq+vwsbZGhKT0LgGJJFSprxmF4aHPRnHvVc6wo2fcQLjIrK+bqeyKT
	 hR6yNlJ3Ix7WK73ArODdRpoZ4vhLvKmA7j5O80kOYDdI0eQqL43yqKW36u+WwYJimC
	 zGUAedoEnCvIkEp9gWtM/IEegad6FN05a59a6SaGqrmKxUoyyAXQSfRdCORN5mfbx1
	 jadChw3FQd0P8jc936i5e6/GBkjSRPcFfgYZ1vzcp9pmClqsDftouvbOZWM1nX7iEm
	 Kc11XMkb+oQ1OvRchkdlb4tjyEzXnRzzTgJT+AiS3Oj0gTo3+p4JH/GmLUFtEaoTD4
	 G58luDBUhh38Q==
Date: Thu, 19 Nov 2026 22:38:09 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, 
    Harald Brinkmann <hbrinkmann@braincalibration.de>, 
    syzbot+eba2b3201bd25a97cddf@syzkaller.appspotmail.com, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: saitek: don't dereference a NULL hidinput in
 saitek_event()
In-Reply-To: <20261015151318.208115-1-ngocthang2710.1999@gmail.com>
Message-ID: <n2s8q6oo-4348-8q5n-1rp8-668373s3s402@xreary.bet>
References: <20261015151318.208115-1-ngocthang2710.1999@gmail.com>
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

On Thu, 15 Oct 2026, Nguyen Ngoc Thang wrote:

> hid_process_event() calls the driver's ->event() for every usage of a
> report, including fields that hidinput did not map to any input device,
> e.g. a constant input item. For those fields field->hidinput is NULL,
> and saitek_event() loads field->hidinput->input unconditionally:
> 
>   KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
>   RIP: 0010:saitek_event+0x51/0x2b0 drivers/hid/hid-saitek.c:154
>    hid_process_event drivers/hid/hid-core.c:1572
>    hid_report_raw_event drivers/hid/hid-core.c:2109
>    hid_input_report drivers/hid/hid-core.c:2180
>    hid_irq_in drivers/hid/usbhid/hid-core.c
> 
> A device that claims to be a Saitek MMO7 and uses such a descriptor
> triggers it with a single input report.
> 
> Bail out early when the input side is not claimed or the field has no
> input device, as the other HID drivers implementing ->event() do. The
> claimed check also covers a failed hidinput_connect(), which frees the
> hid_input structures without clearing field->hidinput.
> 
> Fixes: 37c492c8f6a9 ("HID: quirk for Saitek RAT7 and MMO7 mices' mode button")
> Reported-by: syzbot+eba2b3201bd25a97cddf@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=eba2b3201bd25a97cddf
> Cc: stable@vger.kernel.org
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> ---
> v2: also check HID_CLAIMED_INPUT. hidinput_disconnect() frees the hid_input
>     structures without clearing field->hidinput, so after a failed
>     hidinput_connect() the pointer dangles while the probe still succeeds
>     (->raw_event is set). Reported by Sashiko.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

