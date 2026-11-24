Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795494835;
	b=rdpm+oydeN0cx9tBeuJDU7h8DPiesmDA3MrsvRuKGLOFI2R94MeQQOFSvxOVDYwRWqpb
	 JQMXwWR96ok3wGLT4tUXyklIFCdl9e2Y7qMOzACUmSPuAcF0sUvLiiWYWPGBs4xCiRauz
	 OvjTDon5rWNAyCwSNYk67kLv0hfftYO6nRZzngdfKvAli5NXK4WITYPp7Kh0/9YH11RFC
	 zcFhR47CiiDAo707n2i/yF9iDsl7j4cgfudrJ1r8BVjnHBQgByfNCzr0PJ+SZPGNX37f8
	 qSflt0uUBktM1n+af8h22sm+NbV5grURz043OGolFu6iZUhyliwRSp+dGrbmGBEJwFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795494835;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=NdeN74Wtjt1zICglmVALwnBuGw2TmiMzL+dmKBbx940=;
	b=4eHq8chdknYTmNCH/QSUNU7PFjdaIOBfluCDGDAL1dKCuWdzYEd9N7o50g3K4fi05Zqo
	 ekH0Q7/c6apTbenU1rph4sFe1JLwb289+O2N8gvc71AFmF3VBfZsmouaqlsA8C0Sb5zfv
	 ri+EIqJM95pxRfrRYJopzBQZCFmtkoUSfGxrmadl0EcsIK7xOy9rTUUV4poTOvcoehS34
	 DOUEh/lpC6EpdwcmVomvCmQeuIjirdYSxR+C/blYnl3TdCOvnMovdL1KdaZU1LkXpEuu6
	 CPn3jpksApsmzxIvc4rtNYEjEBvrmbG2fFhbpjyLeESNeOAoUZdvplRNJ136yfhuyNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wmCXjJXU;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2733F606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 04:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2733F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wmCXjJXU
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3282db206d3so1495965eec.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 20:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795494834; x=1796099634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NdeN74Wtjt1zICglmVALwnBuGw2TmiMzL+dmKBbx940=;
        b=wmCXjJXUvwcD7z+suS3yrxGyGzWuDroHMtSouX6nOGtzzH9jFnmlukGW6JKnfgokN7
         7STFd96S//ZdIxLax1dqPQoGoEq03xM2AGKCprp8amCYNEHQr+QvbpuGuEQEeWrr7EAl
         ZDFEeTsfT0OWcOHPDA0oQSs0z17qcPiHo4/+ilpZFYAqPcW0Iv6N00kpEYBKmHu48Z/H
         x5WR1K1xgylmiqvOPOg+DYwQP0KFcAlGO4ieZlVxWOPfehd6C5ielRjirYDN/HI6nnrY
         AQgHxiqwNQ3vOTPX/N9YxqmLj2DpxCM6Uy2ivhv/xLG/TzpzMcSZPcYPKPtaAG8cCL7p
         ElOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795494834; x=1796099634;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NdeN74Wtjt1zICglmVALwnBuGw2TmiMzL+dmKBbx940=;
        b=TLlrm6DLyHpe/QFMWl5pzOSn5OyZ3B4ogGLTqT8OVICaY5r2/UGcK0o84riW1IGyL8
         ZWsDyRJMo+PNJoVkvyiUQ3c4j0tdtqN6HJ+Cl/RrxzKoW2nsDUVRNGmYc3h9PsQFxp+M
         MNb9043O8IlVbNBbubdSIs9np9SHuHSmaIhnK6sRSlon2Y3rurVzLsWtCrFIIjCFwcMn
         ogwo6T1iW4LZWlMNhuztB0wS8wHtApJv0xo5p3e7xXEaXBnHDj+q4vrS3aFS+p0ZbODh
         PYa7wh4HQeFRSCyI6lujQcBHk23Q3XY6qD/MuxPKsOUo0uwyRg3kz9zdoSMTY0ASDWkH
         Qozg==
X-Forwarded-Encrypted: i=1; AL+hErH9mEM8l16MCcsLlYY8hKAAUP1uiuSGLzSeQK3cR4F80rFrN0h2tiuPM6kNx1jmKL5RFtJTzWI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9DOYmX70bi7VsSeuutjN4uIHtIGFGd6Ze7GGFYAnwilTiQkrLt
	ntbPxIm/IZCpgc7hfpWWMNiX56SzLLbm0dJMdrqFX/3kNRDFdwKcKpZB
X-Gm-Gg: AZFdTZcljKd8SIOTR8YI+C7qeGna61Vhxv0FWn6xfHz79+/UeZpRovW7vtOO5dGNre3
	7Cw7aKvdhmvup5YlYOhC01rTaZ4tT9/DAWg0k7a54AsEeyjidMKOwn8Zq6FR0s9Y2Gc3Dv397po
	/QjLRRFmoK+3orQ12cZ/HlLC/+apRehi1VDZy1tatYOPXSUecAyXKDJ5Y1V69h+0TFngks6eSas
	mhzOIqUXhDu04bHuWAQUHnB/EnFL2aohT62dt21UT9MyctTCfFh3tMp+NGcvB2WvfbM3BcXWsvE
	Iwka88MUJrXCVoqYqCMI1Nxm8KLZpJcDKMK6XkK3Nfmg80sm/T6YRy2cdeNJo1Ksa4EqQ//K5rx
	mQqS9NhpndpZto9eDIsRoEIY0wZSMiyg0qvL38l0xWzbcILZBOZ97a4+nkHc7cGrmxCk6m2dyM/
	0qJje8ae06snXNR9a9Ip/l8EXqWNTWJfCEDAw9BNie8WaCVVARILdE0Tz6QY53pIsD3dOAKGkOk
	MjHiOah4voWLDb04MtoAhk4EDI5qU4suAw1xDEQ17o9mbUNPzZvqkyEs3Z50OodsbCmM1PIWiWm
	ut9bN8IFXCn3LVJWGs2bqlbOnHD04Ma40ZcMjsS3junTj+r1XRO/pqRDsn3OWK33tywAfyuNnZ9
	4ncRdHvvYDgYIEiHd
X-Received: by 2002:a05:693c:8083:b0:377:678:2309 with SMTP id 5a478bee46e88-3856ef47a98mr14810166eec.15.1795494834149;
        Mon, 23 Nov 2026 20:33:54 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm49123329eec.11.2026.11.23.20.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 20:33:53 -0800 (PST)
Date: Mon, 23 Nov 2026 20:33:50 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, 
	Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 06/10] Input: synaptics-rmi4 - check for NULL drvdata in
 rmi_set_attn_data()
Message-ID: <awUTq0-QyArghEiT@google.com>
References: <20261123183200.3900004-1-lee@kernel.org>
 <20261123183200.3900004-7-lee@kernel.org>
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
In-Reply-To: <20261123183200.3900004-7-lee@kernel.org>

On Mon, Nov 23, 2026 at 06:31:12PM +0000, Lee Jones wrote:
> Transport drivers such as hid-rmi remain registered and continue
> delivering attention reports via rmi_set_attn_data() even if the
> physical RMI driver failed to probe rmi_dev or was unbound via sysfs.
> 
> When rmi_dev is unbound, dev_get_drvdata(&rmi_dev->dev) returns NULL and
> rmi_set_attn_data() dereferences drvdata->enabled in interrupt context.
> 
> Check that drvdata is non-NULL before accessing drvdata->enabled,
> matching rmi_process_interrupt_requests(), rmi_driver_suspend(), and
> rmi_driver_resume().
> 
> Fixes: b908d3cd812a ("Input: synaptics-rmi4 - allow to add attention data")
> Closes: https://sashiko.dev/#/bug/linux-0165ea80-0dcb-4d48-96cf-e2c1532199a0
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Applied, thank you.

-- 
Dmitry
