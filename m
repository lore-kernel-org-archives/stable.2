Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379174A4993
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001400; cv=pass; b=NevB0ObKSHfaiFND/uGCP2W0FKOEh0LwFh0F5Mnr5soCyg4ciynH5T3pws+EnISS/N+dmF1sEKZet3xwd9lIdLGeJ6XJtlIe7jM9lizwhoLpiJTW7ccCNGLCT7O9pckukG+WCKv0y532yxXOl/HM1xnaKLtXH9QSNmCyYE0iqms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001400; c=relaxed/simple;
	bh=L7K5h9ss5itYa3PVNVnsJLd0vmUVmWWDUWKgAFHYFq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VIht9mEpJVPzCMX3ESLY4L6qcJgctLNJnHQGMb3oiMdfvSJk/Fmq3tHp0QtmqwE5VhafK44qP83n7FCQpDk0I6vV2a1595UzNc+CRUKf0zaffXQqDIzFI/scXcFP7dFD7elOokiD8hfvriXBew7Z1eiTZRH7gbMgEL7fgfaWTaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QImxfmys; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QImxfmys"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab19125so2965600d50.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790001397; cv=none;
        d=google.com; s=arc-20260327;
        b=UIFmsa4QkBlqmwKorYwQdtElAqNPvzHDu/6kfuuuJ2Cmyz/z8+kuYQ6NWa50B2b798
         q7T+pbKBxUDnS1m/qavzhtC1keMjartH1aSJw3G15L+kb4lsaBn4m1U2JUdMGaZGEc0d
         MwgA9QrZXKUvz+NH1apID7w+8Eo50lB/Yj0rYHW/4ox9TOXAd6CZ+zMMlqtqGfEnyfAA
         GI+yk0XP+DhQQ9MdK9iXGRWW74FLVzRSH1XkhxSdu0UKTd/y7dP9Qc3YVoMFD7o2x+E2
         ALe0wTmvMZvs8kZ6s8xh22+1uP4OHiIc+U1Ws9O6piWsFxsAI7MWCYZTee/pG8xWPcjG
         4xyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UQQaX7dLiH9spYaOUwUq19F+SUoVy4mqeHG1ly59DKE=;
        fh=Yaw3416PuOqnPVdM7Xe7bg3Zwb2nY1HmbVCAlw0wRiY=;
        b=PJKbwF7A9NLed1ZhXmkAv9ntUzkV6nCldiz6CetCcAxDYo4FpLqWT7zNdgUjOZsLHH
         qMbPteLwmpQs8eDmKFOa8cBIBOFlGge+/VBxYRvddibmusLBaG7k1LqphbslyXyfEUdw
         OhGN/3GEV8eR/QEcrcVJZtpsBszMIMjwagcLoOG8qNhBo3pitKOsQt2ac07iyJUid3M7
         XT81bZDnWetZpBaQimm2KDTnsUSqiYntE3I7Lec7aBZSH8Mr3sq+F5ovOZbXx9fOU02J
         S9s0srpdLY2h7yw5bM/m/TDNa/c21SGiQhFXqaX667avP2IQ/9LGe68ikv1tPY+fSPm0
         2bYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790001397; x=1790606197; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UQQaX7dLiH9spYaOUwUq19F+SUoVy4mqeHG1ly59DKE=;
        b=QImxfmysaImtqZ+ui3x9VJPDG5rBcvcV46keBb06SfHfbPH4+bbxaJKw1ZGNQdiy5x
         ddqyuT3VOB1jZRsv/13myxMX+H77tz/cL+Jah+OXt62LmgTxoawRj6QF7MkNN1dz93Qo
         D2iq/giyHgOwsSy7j3aXKwSSJAsrtzCoSR2PV/oOy1KQRem1F7nChx8BCgRDrWhCIvEX
         HDKim0r6qIQrMVAglgTzh78bsbduMAUvqnsTyQr/KzASi2RtbzNhOD2MiBk8Kj2fqsrP
         YyQXYq78vsBJXEJTdu3dD/eYJGgA2vxFFpuCedi32xi16kUyoREG0B6YvndItrk7WiAR
         //1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790001397; x=1790606197;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UQQaX7dLiH9spYaOUwUq19F+SUoVy4mqeHG1ly59DKE=;
        b=gTHViZgjtYOQ3OGLixrpzxW6+hMAv9GDtpwjTAedTf37gMZwZbiMPwDBZ3hKSLGHx2
         g7AIFItuC36bL2YY1Gl6ckNXDJSW28hWf99/oUNzzl9qePg289t6qVrvx3iSvvc2hTmv
         THkFVFvJ5iZpyFkaVDddLFirE3aEi25yD8VggCiQWDL/39FXNGwuK9l/44YEAoarztEr
         M1twfjYgzbueTHSH4yyTEPYl36RVM8isyVcnS2PulSXjIojVu4x0iyhF6N2hu7Lpu80W
         2bluDjCvwN/+07/0poX28vzuKCcURVLDSE024OKP1N+YG7Ud1h9K5f2ly23k7gtn7AzO
         boAA==
X-Forwarded-Encrypted: i=1; AKwUvBz6Uipe1j9DJ5IpVQeG3y8GKmnyX2ywnCynH2QLQyYXMhgp3D5yZ8Pa5+sBr66iVS7zdhUM3Wk=@vger.kernel.org
X-Gm-Message-State: AFuF++mMkrv3aln4NJg0146qKZ6bRNhziepSEDJLV+UdYd8DsWd5y+BB
	rNJOORAmyfiFvXqM1DW0TL3I/RzBNje0czIrWNaEwUthRGsGSUbl4uPjZjY0w8w1IpqkQxXaKd1
	oZAors9XLRWXrKCle8twHP6JWq8OZjgY=
X-Gm-Gg: AYBFou2+9lZmFeLtVGXYWbjwc3OyDfARQdjUaiL8McQk7WkJmmi4JwufwsXd+A+IAWU
	iQ6yJvIJes07At7ICfdoM1D25x4JI1qBwPaw73TryrpM2B4ZsqK9g00jSFErWaLbga9saqKuEjN
	Ng6B8Ly6LUDEnedB0b2fMXIXQ7yIvqynPSolZ9B5z34KBoYS8lkilnPILKl+UoviQx+2aRGeOvF
	/XRa9HmgheBhmAtvEUsOyCMKjZGtZUH0EpP/m9jyrXF7+cIum2MLjTcbBeQSGCImDDeO8tC6ynV
	C79yxDHh58y+Gw+PC0nOL6SJeMSMQJW/2TmB0fmZpRthGeQjRJxrGDsz1Q==
X-Received: by 2002:a05:690e:43cf:b0:66f:ac49:a27a with SMTP id
 956f58d0204a3-6717fc65521mr2383542d50.14.1790001396949; Mon, 21 Sep 2026
 07:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916051618.2904439-1-lgs201920130244@gmail.com> <178962811102.1264013.13698060411191875408@gmail.com>
In-Reply-To: <178962811102.1264013.13698060411191875408@gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 21 Sep 2026 22:36:24 +0800
X-Gm-Features: AcwNN1VX0XaLkydRZySUPzjNak9mjroYac8VQM-fZ7BBkk7Judurvc9M8LXCNAM
Message-ID: <CANUHTR9Csn86KgVMTCBPBobAjg78-M3TR1VTz--yLyG74w6YbQ@mail.gmail.com>
Subject: Re: [PATCH] net: mediatek: fix PPE resource leak on remove
To: Wayen Yan <win847@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Wayen,

Thanks for the detailed review.

On Thu, 17 Sept 2026 at 14:55, Wayen Yan <win847@gmail.com> wrote:
>
> Hi Guangshuo,
>
> Thanks for the patch. Calling mtk_ppe_deinit() from the remove path is
> the right direction, since the probe error path already tears PPE down
> but the successful remove path currently does not.
>
> However, I think the cleanup is still incomplete.
>
> mtk_ppe_deinit() currently only destroys the per-PPE l2_flows
> rhashtable:
>
>     rhashtable_destroy(&eth->ppe[i]->l2_flows);
>
> This only destroys the hash table itself. It does not free any entries
> that may still be stored in it. In this driver, L2 offload entries are
> struct mtk_flow_entry objects allocated by mtk_flow_offload_replace()
> and inserted into eth->flow_table, and bridge/L2 entries are also
> indexed from ppe->l2_flows via mtk_foe_entry_commit_l2().
>
> There is also a lifetime mismatch for eth->flow_table:
> mtk_eth_offload_init() initializes it, but I do not see a matching
> destroy/free on the remove path.
>
> So I think remove should first drain the offload flow entries, using the
> same per-entry teardown as mtk_flow_offload_destroy():
>
>     mtk_foe_entry_clear(...)
>     mtk_wed_flow_remove(...) when needed
>     kfree(entry)
>
> and then destroy eth->flow_table and the per-PPE l2_flows tables.
> rhashtable_free_and_destroy() with a small callback would probably fit
> this better than plain rhashtable_destroy().
>
> While touching mtk_ppe_deinit(), it would also be better to use continue
> instead of return for missing PPE instances, so later PPE instances are
> not skipped.
>
> One more minor cleanup issue: mtk_ppe_debugfs_init() creates the ppe%d
> debugfs directory, but the PPE teardown path does not remove it.
>
> So I agree with the fix direction, but I think this should be respun as
> a complete PPE/offload cleanup rather than only adding mtk_ppe_deinit()
> to mtk_remove().
>
> Thanks,
> Wayen
>
Agreed. I'll extend the cleanup to drain eth->flow_table with
rhashtable_free_and_destroy(), using the same per-entry teardown as the
normal flow destroy path, then remove the PPE debugfs entries and destroy
the per-PPE l2_flows tables.

I'll also make mtk_ppe_deinit() continue past missing PPE instances and
send a v2 with these changes.

Thanks,
Guangshuo
