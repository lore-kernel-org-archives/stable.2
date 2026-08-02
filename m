Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3721A1B85F8
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785662853; cv=pass; b=GfqbiGmnwRhKRx5C+DRU7xv9LD+n2DudHWNEUkY7ESNF5gOSEmuJvBMk6Goejy3a3HZih/bxNxUPxYsV/DOvh0x/rdC/ywEA7Ro08sBFFk3WSi00KkUHzmMAgQnU9KC68t7OZg3GvOJwrVlsqHwy5QDOPz53iTWuE2qqcuaMgic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785662853; c=relaxed/simple;
	bh=DDLkafTD42OBeZJXOS6YswoOoFV1f2bJBVplTPSIAaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oeX4zQBT5LYD+2YnxiT4crGJFXGbT5hB+iiTRLfnnrInVn31Cp5272gdkg6/oWoMWxWEZXT/0yK4lfHfeCFh/qGvAxEFDqJvTeXLgxPWJ0aTe2l8MQjJPB9R7w6ud87uNZ2W2UDczwbTXb01njcOI7yjdLyyhy8ZI2+2kHobqjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmz8fm12; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmz8fm12"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15ba3a2b4bso292189766b.1
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 02:27:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785662850; cv=none;
        d=google.com; s=arc-20260327;
        b=lw8ce3IaxdoFfzmYv1Qfhx3+jQQ1YWkSxNGooAs/qFYhkQPcP4x4fzLYBtho1DTLWx
         77CiI3O7LJT8ZVijq5Rt4MsUVc+xfgFvQOK0Ls+RM5jYyrIyRWTaV1/7ypaczvMLHwF4
         BLwaUfnD942O6PMODLziXQm4ay2Fwzx1ln+NZMLvswB1CPl5SE7edcLlM/jLxeWiJcDE
         g5BkiIxS3NIqwu91WmZVLKfJpQmRf7u7dlSRlj3bdQammcO3Q8+Bn/z6Qqx6QYxtb85Y
         P/MR4QYNo7TIrrkTE4x9jZKawvsTHtyJ4EK4JWQklxMrW7dD6lzeK5r3sKH7btUNYjVn
         GwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DDLkafTD42OBeZJXOS6YswoOoFV1f2bJBVplTPSIAaI=;
        fh=iSdkSliEPgUDp75lt30bcW+H+3P2IxPnTGcY2o1o7sQ=;
        b=i49YoEhWR8U5q5siQMg1S3KqtvaRE6LWT4JXeUXYCoh5fAg3G07TN9fHv95lqn4mFQ
         yEXG9Va7n6ea/W1l64pCKTsysUyZAKe1gb8CbnX4jKO+S2mi4+G3CLsZnVGVFe5u9OBL
         K4l35MxGfq42yI8ji1vy1KUULQja0ssuNYSz7J86wnXLd+2uZzyr66nH7JGSwxRXei9q
         T+P/ZSlJzaD4iG16JLD9x3gErHfqvPe0pywmKCFo7fvKw0rL1CZaQQJh6x3d3XluOhQx
         Sha69RUNle5WlSWQhFZTez8T/IJr9BVL6wG8PZ9gLG8GdoRQ4DkVpyxghN6QLmoar7aj
         b/ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785662850; x=1786267650; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DDLkafTD42OBeZJXOS6YswoOoFV1f2bJBVplTPSIAaI=;
        b=fmz8fm12vke8v8fW3lkDl6+oiOh44x7Hg3rsnRcwtQPMXPJfsZDps6okIIG/L9yhN9
         YHfqUfA2kTgsuCMtnew4bjiSC3udzemaH3168Lwr3LA+xXQo+L9XtHzMojeY9vQMtWQe
         4WwDTWV4IVtd3/gjZ799wcfo5qr3FxRAlVir9mFq/hmZYy8z3WcCCLFAdmVH2Y7D9bUZ
         GalXjdHN/2Cd8E5trDlKhSvW22XTEDGXObKQWJfb5kUolLFpzvifMj/ox3Ve526O7UET
         WYnzoAt7ooIMqAuO7LAQHsA3zsF8gSgLYeJ4vADS/bidgiGgbhnGPBBGsYWfF/X85MMC
         xveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785662850; x=1786267650;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DDLkafTD42OBeZJXOS6YswoOoFV1f2bJBVplTPSIAaI=;
        b=MPFaoMUwDQoZDTXwhDaLVG0WFBeHB2Rk1ltDkQXS3gbeX7gEQqJyPKrSxSF0q/tZ7N
         Q85fZuzDq3+IbYxFNmobg6G0+h8cp52eNaCmLgQXcSWxMO0Ebsa6XoL30oKat3wZ/qcj
         PoO1jT+dR0cqHor90+jG+yTwgcDpnXbecXMKQKMCKQOP+hHEcJHYjXR7NP8m45+yFEs0
         vVhgNMSXyita24fjLyBFLka2cjLwoViIrAFZm/HJrV/1PI4HPjET1tOeV9evj/wwBsc2
         YPxSNgIxFlaeyK73p6zEzjd5ZFBD8TyJb+MfKEftLyR6dOs7hN/wsfRXTBedWVmOyQHa
         0FVQ==
X-Forwarded-Encrypted: i=1; AHgh+RrwmlqV/J5hnKw1Z7Pee3TAhwu8F9uzwrrDxiQaKoG9MS9X8nNQ2tun+Xrwtxpb9pKpXfkL4Mo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3l1KoKZ2zljzEK+4aBiUMRaTWhOK5uZPEG/Dx2EG2PTl9Fn+s
	wQZ19J8bjNuXhOjIuur3Ko3KGfJ1RfFKINmb0Fk5Y2AJ2kPTEa2yxOp4vl5vNPTWLQVMyCN6d9n
	81BdlBHcPThk4rGJr6B2ERFWKoCsq4pU=
X-Gm-Gg: AR+sD10zHYWPzf9lDu6Zyq5dgI5tkaGd45JBCz0kP6TVbzFHS+DeE2RFa4UB98l4bdD
	1GRtSDH9G9nXH3V5G5X2m4NczN+lLGxaB7CXsg4u6FKvRknesOl9tnrAD/hqDHZY8ZbO2RMbprA
	+d4F1fBZsTGDBQBuVZnUvcxdCFU6SlFvK85bxGbZl7TqHi0exsnMkWcUfOEw1Qsj5Y0/rxYlMBs
	9qfpiiWE1+8418c65zfHS4FvZxewZCJFDtUiF7I7bL8P5ElLKM+HIfEFUijxD7Ez/+8lhPyeeK0
	WjcIlGX1+SgnAJGPGlmE/tQGFaeQTcw0mqoxgAFLl6l67fhYLHu5I/zz0FTDuGtNp3K0cT9zatd
	rwkAuJYjJ8VJwwBWBH9iF0bCXo77PnDd2u1NiOG7oy1WzTnElhrDbIuh+fMH53QwhmGclPQNAs2
	XICXPmiigJRa0LH1z57gI0knVVVxWt/QbRXmSVchfOZ+CzvVv/SrqGi0SWIfrRtiAwbYFvrQWxX
	nI=
X-Received: by 2002:a17:907:3cc2:b0:c16:3074:6593 with SMTP id
 a640c23a62f3a-c1fe7ec89f6mr487092766b.12.1785662850254; Sun, 02 Aug 2026
 02:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801200150.60098-1-acharyalaxman8848@gmail.com>
In-Reply-To: <20260801200150.60098-1-acharyalaxman8848@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 2 Aug 2026 12:26:54 +0300
X-Gm-Features: AUfX_mxJkQcrainugvLn2PHYwILwv2fBc5UFl1DchhsNWhn_W9XbxgaZ_FENmSA
Message-ID: <CAHp75VedeccKYMoNkkPD+-cmi_mDpeeLLSW6tjq4rnrk8PKCGg@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: linedisp: serialize sysfs message updates
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>, Rajat Gupta <rajgupt@qti.qualcomm.com>
Cc: Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 1, 2026 at 11:02=E2=80=AFPM Laxman Acharya Padhya
<acharyalaxman8848@gmail.com> wrote:
>
> message_store() frees and replaces linedisp->message, restarts the
> scroll timer, and may immediately read the new buffer again to update the
> display. message_show() and scroll_step_ms_store() can run concurrently
> through separate sysfs opens, because kernfs only serializes operations p=
er
> open file.
>
> That leaves the display state vulnerable to concurrent readers and writer=
s.
> A racing write can free a message buffer that another sysfs write is stil=
l
> copying from, and a sysfs read can format a message pointer while another
> thread frees and replaces it.
>
> Serialize sysfs access to the display state with a mutex. Keep the timer
> callback lockless, and use timer_delete_sync() under the mutex so sysfs
> writers wait for any in-flight scroll callback before changing the
> message, scroll position, or scroll rate.

I think this is an attempt to partially work around the (security)
issue that Rajat reported earlier. Rajat, can you check if it's
related?


--=20
With Best Regards,
Andy Shevchenko
