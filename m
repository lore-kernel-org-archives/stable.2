Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792856347;
	b=zNthm2nBfki4pdngnBAJhrMn9fRdr7g3hxRkHRZsdUCIRTvFgsGv0GdDVtRXASESqbEX
	 gdgHdT51fS4ta+XyyRD/g618nH5GLgl9KP/2bX721aKtoku4znPW/N2TWIJEAm8LfY8Hc
	 KFkul2xci1T4ie8Mu4HD1nyDY1fQKpq9kx2DFbnudg8aCndvwBr3BalRUBgmk4rc/4zNh
	 KQRBCjNKBNKi+adfrlEYTLrHA2irl2gjmfMSJQYfPoCNTC/+tJeOW7WNhTPT1dYbIgYkj
	 TVhwnsb6AjeAKivmuYOCKMHldIU+TcCXH+idSgDh37uPysQIR4LMGja0LsDqVIQJtcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792856347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vK5pr9uyYz2jsZwQQgWCPkEz3CYe2XwtN4i5/OMooOs=;
	b=q/IHOtYapagIBXhx0SoXOYPxubT2TuaENvPIl5CRnlcWFD4fRwYUCVcsWMz8QeEoRG+2
	 +3txHGWFWIGlhL1t3vtwfH5c4LBYFOYd9+f2xu4CHl6i3FD/dEVdz3dYBLn/KfGkUNmH8
	 94yYQORsJu4vmhXBU3QlWUGmQJu07EP1h3wpVdGB2wLNGuDwRP5xzrd8Z7MRyKUnB151P
	 liu/oSZlUL2qpgYqepj/CMiugD96XIC+Twdjj+hgHRG2ycwyeHALElr1pKlc2/+xpcbfm
	 sLbHX4O1Njp9U1mv0IQTOtPgFF8XfvpLhsk2dUhZjoL2umQG2Fue/7jI67Eq526NCFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DhHBvhwd;
	arc=fail smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCED606A31B
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 15:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBCED606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DhHBvhwd
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6740e7ae219so1706840d50.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 08:39:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792856346; cv=none;
        d=google.com; s=arc-20260327;
        b=FiGRTNiKCsUE7qKMZi36G04I7FyXHJZKwU8d1Myjlp5ro04bXYMSuT2sPrM6RsLsT/
         eIpgDUEFaOKZXhjelIkikXlSaUSCWpCy57LLyW3BgSjqsxgBhcD0bXHQmC+fohyIraRI
         yDvvWyIoG8kuUmtw+8hh/g9ksy7qkWUnl622vME7c53y+gcVtew/vEiYzr9pjfjBvx9F
         IlyLDhMKpTNRzQTLndLHPeMNP6vg8Eo7ORklAfl6zKXSGcNxmoHK6G6uRJfCJ1qPDb48
         +KGS0XrufHSx2uROeRrLrQqyytBUWqzpqNotHmL84S3I0zoCAziz4Bv8sAqSd9CBeqWp
         hdYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vK5pr9uyYz2jsZwQQgWCPkEz3CYe2XwtN4i5/OMooOs=;
        fh=TzaWcNOAcEP7sgfpe+RZhre8Gqqn048M4Ht5c3F7Gvs=;
        b=jjN5PGEVGWf+70DOgd1Xkf+C5ejtKDyjkyFFAx5c+VtFgmRNlF9kuh7JEBPQzfUIIb
         7opv6Bq2BNTMa/XbUfs1VBlOXgGs/y902ghxWhfv6TmdSqfZYBR9A7bKaTMleknfbpGp
         uK9G48QT4pYmtCo7s6jkPWnuNWCreChp7TMjpvKjEamhNvjaalJghqiMuYMQe9OYuGaa
         q0bFgGGp5R9v7mUBDru1Sc7Sua0Sa6kH+kT+mIp7iNXxF6k4JIbpd8880y4DiHDq9Is0
         8/sBTQak5MQSIHh2cRbDpIpZSwB0F0aBuw3I2NnCJg6JynxWEuz9AwYF9FDoWoWMtunh
         E7Tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792856346; x=1793461146; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vK5pr9uyYz2jsZwQQgWCPkEz3CYe2XwtN4i5/OMooOs=;
        b=DhHBvhwd2VBdGFg7LEvt+Ab8YuLjqGuhb7V7AnAadBRBVpAzqKcq8TvHE9lLXlK/Hr
         ruKtZgu+23KmXQy66OvqY3JniW3MgfiDipyOHprnHTb2sb0oZ1Yxh29zAstQ0okE1u3F
         VNhPOCcqtDcJulV4uniSIb/ZbXJyXXqfyoYD3UjK4+H6G39mB0kelM9R+fB8zlcU1ltO
         Ub7jg4v+GfkuqBFs2dlguA4H6hXAx3jJ0/WzmNcR7waAgZoJ8zlBuBO7asw6tKYhVMNu
         flKBLWItJJ1pwgoPD9GTKA7YzaND/uE7FToLxrdds4/44wGMgtPXB4uGG9NBssqSt3+T
         SF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792856346; x=1793461146;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vK5pr9uyYz2jsZwQQgWCPkEz3CYe2XwtN4i5/OMooOs=;
        b=uDf7Lgagm6jQ1gZgMSTM6HEjw6NCji4gF/TosgCbX81HvJwia1kw6JROhpRXXjojmK
         gqwM6nDgWP1gGGRyXf2NHzpirXz1avVz1jQvU98ezR39bw7rjdeTZqnmRme4lFJsXx5D
         u9sWGeJrn849HbPscQABFKHJ1HkScLf5Pe57aXa29rNBLfiosCqEvXxCrkVEeL7R1CEr
         zCBBhzXrnMZDzuwTJFMGEgMv8HDNdII56gEL9dY4XA/wqi67CEW9BrpFOGLpdMaqv1vV
         vNX1+fh9U0UmrxAufEfraXyjjmPOXAEW61lW1GLD1vTVRtGcXUwypTGLGjq4n6M6fC//
         5qfg==
X-Forwarded-Encrypted: i=1; AKwUvBxHfma42FnUnWl/Y2nYmEFhhHrB8/aqXMB2KXgDAZO6g41dt/pQfNcJNXggIuBqog8wWcaRkjk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJR0n7ilFXkCSM+WmlN3OmXfIBt9UUF84EPUIHmlFBzdT+uxorP
	YAZSDbB7Vr7b91DoVfcaQkCZjbL1wRGLdnnvlBkp4t83NQZjGGw+o3HUcUMiIPFLBLNRNQUycc4
	EXUzZTSuPv88ENZOAE4YZ8yNUQHoliR0=
X-Gm-Gg: AYBFou2UGrcnz7lNe546yaBgkvGZAvEpXa4GxhwLwbYrM83Co1PjBXK/Kz57Cbp3qak
	Zy25S9VP3ilwdwfYMESa2LNUQSs3iGCbvkbPZKeQG6cos0CPEA2yV3vnI0zVhhhO12Dnef5UFq/
	JwE/Zqu7jTOEGfN3XTWOFzh2Ho+Bj46DGwLt3wHazqnO7P1QC9PPWU8md5B+EC4c6BiKDmbkFs8
	Tj/K+NsNk5Qn6rs0F5j5/nqHyu0RMYRH2q3R/EMmXJcLU8q64Ej2n/V35/3XB5h4R0Bg2L8qGrK
	tz2HGIZNVjD9AITJenM2rp9XyOq1S99+zZPBVj1QFp0f7N31VJIpf1hvW73sbuAwVnfaOD9ZR58
	GBVcTAhtZqRzKs7uO8+oWXfeMjmJ9Jmh2HGFdTLI=
X-Received: by 2002:a05:690e:4193:b0:67a:3417:1747 with SMTP id
 956f58d0204a3-67a454179demr1093499d50.106.1792856345704; Sat, 24 Oct 2026
 08:39:05 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pm-ocfs2-objects-candidate-0012-v9-eeb9084fb29577971229@gmail.com>
 <31b48648-c157-49f1-94d5-d1b927bae1c9@linux.alibaba.com>
In-Reply-To: <31b48648-c157-49f1-94d5-d1b927bae1c9@linux.alibaba.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Sat, 24 Oct 2026 23:38:54 +0800
X-Gm-Features: AclHuK-pel6d6vEds-ViiTQ9UC2ScVH00hRCkn1-aVXEOr3Df3HDB0eQcYBlZ5E
Message-ID: <CAFRLqsWiioFrCmXjzmrFaRBNH8b_JryTgwdPrLie4AF1GbKsKw@mail.gmail.com>
Subject: Re: [PATCH v4] ocfs2: cache the mount context for dentry lock callbacks
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: mark@fasheh.com, jlbec@evilplan.org, heming.zhao@suse.com, 
	ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joseph,

Joseph Qi <joseph.qi@linux.alibaba.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=8823=
=E6=97=A5=E5=91=A8=E4=BA=94 15:09=E5=86=99=E9=81=93=EF=BC=9A
>
> Don't see any difference between your v2 sent before.
> BTW, it seems v3 is also missing.
>
> Thanks,
> Joseph
>

Sorry for the confusion. I rechecked the early inode accesses you
pointed out in your v2 review:
https://lore.kernel.org/ocfs2-devel/018d8feb-2e63-4a73-ba36-10a5f94f3341@li=
nux.alibaba.com/

My understanding is that these accesses have the following lifetime
protection:

- ocfs2_dentry_iput() keeps the VFS inode reference until after
  ocfs2_dentry_lock_put() returns. Lock teardown waits for QUEUED to
  clear if the worker is already running. The rename path likewise
  keeps the source dentry/inode alive while dropping the old dentry
  lock.
- A final put from ocfs2_dentry_post_unlock() runs synchronously on
  the same downconvert thread as the worker. Recursive processing
  from ocfs2_mark_lockres_freeing() sets FREEING before entering
  ocfs2_process_blocked_lock(), so the worker is skipped.

Thus the early access does not rely on the later extra-reference
check. A zero dl_count can still coexist with a live VFS inode
reference, and MAYBE_ORPHANED still needs to be set on that path for
local orphan cleanup.

The asynchronous DLM callbacks can overlap the final post-unlock
iput(), which is the separate lifetime window addressed by caching
osb.

I incorrectly moved the orphan marking past the extra-reference
check in v3. I reverted that change in v4, whose code is identical
to v2.

Does this analysis miss any path that could drop the last inode
reference while the worker can still access it?

Best regards,
Cen Zhang
