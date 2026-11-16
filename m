Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794796615;
	b=myQ55rZONlJEEQfGlUi8A3YOp2oCyD7bL3m/OSEPm1EJ1M3PZRUF0MI3artyE3gFgqzu
	 +3tMV5no8bBC8gpcoYwzwRo8qFeIExVKFA446XctYyKh4jwz2UHSpI2xJAZbXt0E83T5G
	 kEwDln39VhV5w38MCwr068XHVK2qFXB4WSIGccWtV6QN/rzxarm6++eKrBsTzpCj4SPEp
	 8lm98bEBb6/0FapmyoRcbjGXHHile5RXRNnv31HoQDzjqNztG+Ub8Nk51i4fwbI7Z3XH3
	 /LGHWEyonCphKaVQRkT8U8ZtqChyXA04KJrc46MAkL6fcp4Hu3FT7djQwqwWSn0Qy7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794796615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=xX6CkA6Wx5SU/AcLVgEPrjNCEuQtMzhCBWWoMNoHGPg=;
	b=wj40ShTqQKfwq47XKlEK6hqt4pMA+zzfZmFanFcRjEYH9HSyVk0WtBrbbydTr/ihrsLy
	 KbLDMZWT/QCnA+Awv9/es2BwDKdz8uTvmtbYgIU6R7yLYTOaLcX6Qgfj21FOxMkD/teG1
	 wPwYNJe6wLA8Bz45DyRnehUBaa2CNjRCWB/yqZ37AoDgumtqzXSi8WQg8eFBlpmDS7YPa
	 7SvpJNnyCwqlhdntcY8YqG66dQxAKz4Y3ul5l9K4swFFv0v1fPj+YXFc0ZHIqXG1WifCe
	 F4jYNpdHJYKqGLoiCMKoLgllVCF9irx2aH8ZKf6w1d8tHZNTHORFqE3sPEyOgRaZlhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l4Rist4w;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDB3606A321
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EDB3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l4Rist4w
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1b3b4944a0eso1091131c88.0
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 18:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794796614; x=1795401414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xX6CkA6Wx5SU/AcLVgEPrjNCEuQtMzhCBWWoMNoHGPg=;
        b=l4Rist4wafGh61eo+v58em7wU81hSwBFHNcD+KdFFPB/2ZsmziQbgN4UCq0bUSgPOQ
         OCnFSgfdhP+BhEcshU/sZAqDpIZRdp9InRNM+i2epJBSi4G0CPQWPtDfiVWXskF8xqkG
         Y6yMCfVibIRJi394ZetkeDRrTjcYYJj46Uks2VMnki52NNBd39hKR6e6lyrxmurii+lp
         idoVVpPPh/o/p738Ayfw0jixFgwvI0Pjbmf66JxDM+vYaU/bMx0f+nJgQPOExfLDSkpQ
         cOEXtDa+lTuLBBbV9a2Zotb/5yq8vDyi4VjZ4oKoPTw6s5Pkfa51AqqbyXCMauvFdOwk
         EN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794796614; x=1795401414;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xX6CkA6Wx5SU/AcLVgEPrjNCEuQtMzhCBWWoMNoHGPg=;
        b=LYTE3EVxOSAgJ/16A+Chuz6UlUTiDtpv3LldKWdFBO391f7mKy7MmhF4nXG6E9dO2W
         tDI6g2WgEmnRRu4dFSrrcFWDHgP2HQGjuO1S6BJ3t1RwVMtwhjwMTpIj6h0LIy85cpiL
         CwA6g/FhQcbJ4r32SEMRsPDIaX/aLohlBLxPNxN+4gJNTPxLEN4rmqq4Fa/S38OQ15U6
         E8H85Ool47zXCLN15oZKhm5y7HvL+M38q1wA7wWOOgqGygPqE1W1qTXQCCZiJYCw+0FH
         o76CprinPzgmZBRGF7g/9tQ4th1//bFen4JEtXc1zDGSKhhEId6oKp/4O73MAA3atcIu
         4x9g==
X-Forwarded-Encrypted: i=1; AL+hErHcTAO9u/wY8aEYTIRf7BKBpCPEuoJIOFWbr0Bx9F/hiEahrp/5JT2QBgnCi47uR7e9ADMXZGQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+f4hnTuD3cnRsRb1HUvnsUey2OgKF4vqcrcqnO1El0KfdWeZPF
	8qi4Nd2T9U1CJknatmgSlbo1RKCpM5WP4+Z47E7maaBDCDxOQmtCfUmI
X-Gm-Gg: AYBFou1ABGipw5rBmUMFO5pwOyp4R3IZRrOofHTEGhK38u2rd0EWfbLkYGQqe8995oh
	GKqliCqBEcBADmwTeMVtJKTDOJjPEiV360XswA6RLpBit2UIf/5Zna6/H3NSdNERkQxa74nTM7j
	gynIOWS9zKM0ifJoKdlI2HL0H8iWq9IWPPGhXBgwJeEsDt+W09kF8eUC2MVwdBj94gm3T1KWYKG
	WOdj+9jL2x0jttkL5qwDSrsdXCPHFwYKYQULg+fjJtrrLM/cpDdf4KVFVo0lxExX+msrZhPrJVq
	NYWgTEJ9Tc7Dz99bAB4Cw4QKaxIdDrUib80EBbjgIAQT1Vh+LB+ADc0iaqFRymsS0XfA3zRdzYW
	kwoTlm39SrfRzhGNprrgIweuhML+1JWRRUyCQUq+zp70WDPWU+ZFfMUyi2LfM1w+rglxWLQvtdh
	qk6q/6SithfiXbUpQR6ioW+dmFWPtfkQFUjNl5F5vI9fICWEsrBYVwyuVnZZ1GF73fKFNXezK+t
	8W+UMnFsQcAI8hh9k7kav5qrvJ0ufeP2foUcNxO4Yd1Ezr+cHpirDw6eBk7jpFWR1RAueRJXZpT
	67tvmCnweV77FC83GJlqFj0/PTcw1yncpcJ8R4aUmjCn0gHDnkbIeVbSUi9AYPbvVjVeHA==
X-Received: by 2002:a05:7022:f109:b0:1ad:4ef5:ffed with SMTP id a92af1059eb24-1b50313d936mr8152988c88.38.1794796614479;
        Sun, 15 Nov 2026 18:36:54 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:203f:d9b9:dda8:24e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm37357720c88.9.2026.11.15.18.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 18:36:53 -0800 (PST)
Date: Sun, 15 Nov 2026 18:36:50 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Input: lm8323 - drain PWM work and finish with
 outputs disabled
Message-ID: <avpr6qngp8rfJ9Fe@google.com>
References: <179474329214.103840.17616107855531843241@seu.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179474329214.103840.17616107855531843241@seu.edu.cn>

Hi Hongyan,

On Sun, Nov 15, 2026 at 07:48:12PM +0800, Hongyan Xu wrote:
> A PWM brightness callback can leave private work pending when the
> managed LED and chip state are released. Merely cancelling that
> work also discards the final LED_OFF requested by LED unregister.
> Flushing alone is insufficient if an earlier fade is still
> running: the worker waits for an IRQ to requeue it, and the
> managed IRQ is released before the LEDs during teardown.
> 
> Install cleanup before registering each LED. Once LED unregister
> and IRQ teardown have stopped the producers, cancel its work and
> use the documented single-END shutdown sequence: put END with
> RESET set in unused script slot 59, stop the channel and restart
> at that slot. Do not overwrite a running brightness script. The
> engine then disables its output autonomously without another IRQ
> or a worker accessing freed driver data. A current long RAMP can
> delay completion, as documented by the device specification.
> 
> Found by the author's in-house static analysis tool.
> 
> Fixes: a48b2d4a0091 ("Input: introduce lm8323 keypad driver")

This driver is being removed, no need to patch it. 

Thanks.

-- 
Dmitry
