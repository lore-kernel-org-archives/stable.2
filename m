Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793633398;
	b=OPMRPS5M6Iz4T5+ieCr6CNw4FWXAR3v0YNj5e8S/v1Fj85GwMtdmujuyW9uN/Luys5gi
	 e7w2LJXf/QiGFsamBjXgeFZM1PHXBi4xsWd6Xf3WhXy+kreZ+Ob+TXqtCGLa7ZDV+Dtzk
	 5cW8jTxJ4vkcq9AtjN7tipHXWSmQpSsxQeE6+j5o9oNBbnzMewnGMXCIaldH0mBm7jBUG
	 kHdgWZV+bkQ1m5WuppB9XTG7uxcJQDvl8yfcBb76GsRs9j7E5xmXko8DZKgIISuOmqt74
	 51DtrFTwHLQxYL0PGUqvstCR5whKkFLT8rlNVBEcOpDa+HSD/qUY7SfcOnwfOi0E4OA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=P7oHHMkIM1swADUlplUIw0AliwJNApZ8BZBXp6ze1xc=;
	b=iVJcje/5pT1ezqWJnhD50OHARBvtCEYFIAAq0OYYI4ptjOdu+0ciCAoMvhx8+avswaXg
	 MJ3I2GywJx1Wi0MFn/UE1VEgnJldj5cbxGKTmp6IVyf5HOEdXeZL/iNyb8dJAOiM1w4j3
	 4oOf4mFNwHZStCInXg+llcTLaaSqvNnPIA/nm0wVf3eYvP8y2URH21w2OSCaTLH0s5jLk
	 uhQ6HdyOmu9dWsnqFV3EuO/DbeoDeRq8SQk+Wo99S7/vy8DPQZ4i6YgxeitzCBOd50wIS
	 Uy9y/BFQdeu+R/YPhLdEfENAnyznE+Z+7c0dkXgjJ6bELg9k9om4tp2EZYvynB/t0/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DPoB7zEb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEE860D2BA0
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDEE860D2BA0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DPoB7zEb
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9906a5410f5so3932702241.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 07:29:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793633397; cv=none;
        d=google.com; s=arc-20260327;
        b=JSQaIlR08FscNGvCAJZZ0Pbpp84SANM8ZTKeei6FnGE9wsaawjPPbtm/rHvv2Treu8
         9y1/XE3lgFxlmLtNGkRlBhFro5F2sY9y9iZAggkIllCRF4qFDMyjIkH81e5oPCiFrzPq
         O6D56JdlnhMrQY9VSerz0QcKTBpiiVhofpYNyn3FrT3Pe6LICKziimYNw3rzY6bsdb0P
         XblALcPdSWT6Xcz4SmB3yrsjcOkFJtK/JQxJibB9JRH6HhdvU5wEow+Ik9EWv76cipfZ
         7CVZ++9yXkMHG1EHBG7soheXushSmELLfyz23vkZpE0y/QoHSv0/ybpQm/4EwmQ/TbN0
         eYsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P7oHHMkIM1swADUlplUIw0AliwJNApZ8BZBXp6ze1xc=;
        fh=HQJKl8ElSz9GDoU9VggMvjIp/P+E8Z9sPilUIYMqz8k=;
        b=C759qywlYyqnaJzViBFedUQ0gv7w2JpGEoOCLEDBebGHp9DOx6/5LA24QBenCvgzny
         gGDSLHeYzztkTm5D6IocQ5Ux7NBDnqnSgCxEsMgX99nzniFQkq99k5ti3F7Ol6HikTn/
         qOA1Dhz6so1DXHTw0CMS1Ur1i+qOlk46aBwrqTYitLhQ6Ip7IU3oEviIzYeCJT4ixUgG
         5xGL570KAshQ14boSL4LbvxSPNmvKTdr37UBOJ8o1P+OMNfKMO+5LWClx5bPAE5g/30B
         CqqSlF2NiKVXcWEwvgPXp6kqabvg9LGCmOwKUOtiTv1HdjPGlCNmXjku2ZEbrBZ5lVmm
         sIVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793633397; x=1794238197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P7oHHMkIM1swADUlplUIw0AliwJNApZ8BZBXp6ze1xc=;
        b=DPoB7zEb46bWtdTF7JIKZ0Wo33TffI9DxLqdPRgUQhsGB4mHSFJlFzSIOMGV5PtPFa
         2kXsamgrfS5DXbQR5pqHDJsLlXJ3Qr0cYdm6AOXSB+i8lturJutBvpA/qfOWYwX1/s/W
         7rX+QeVytIAVoxAi08HK+WyKT9oBk5KHBiRNi9q97xMdhbQN8jm02w3iFU7/L11XOU6B
         tqpTBU2wla+w5DSOO/Wuv+0C2Gpgf74xoqrSMsak6dEoS3Pl1ASyPgTeN2471WA0TfH4
         CL7cppNNBD/wtOO549kHZxnvDI+RG1qCoY2QfSpL3kK6QFRmG+vI+M1mtR/VwEi7FD5C
         82MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633397; x=1794238197;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P7oHHMkIM1swADUlplUIw0AliwJNApZ8BZBXp6ze1xc=;
        b=hZdXy7RaJBouOtdyDEtOoTHztS92/WPW+1bSso+0/cGaRJf0Ue/Cuh4IJ5UZQDernW
         FJm8HAVtY9dOLFFpj+myekK4ng6H3MoWNVrEtNISK/TfnJK8BSU/inHS5i8dDj2zU6qa
         W2uWPSGgTEBhmlDC+64HUpMdd4lCFb4/alvXLve0XHOY50k0yndIw8aAlLxRmfpS1G/2
         /8zgNkLLG7JDpmRKT7mItbtZKaKVWEbgAOOzJhzJ9MPWxj/Qx8c3GP55ruA13bTk2Fx2
         V+ix5sSCBBeeMa3JqP2SM7ziwlC4P6mV5GozIPlA35qQg5aIkeNRqFJQtHtkFy73+xqt
         srdg==
X-Forwarded-Encrypted: i=1; AKwUvBydLnXpVSR2VkxZOzYj4g3Hc/344u99b6BaU2uAJopc2eKSnp0M6PpzWXxEanS3C5wGmCMT4a0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/GXKZI268g2Q8LOGM97kl1F1U+uptrV3GXFILaL/D2NoS6lrZ6
	m4/lL/e/0MHuxeXRA0RChY3SFHxoJef1JnNklDL8DWE4Tbfl05GuvzZrzr363lDcgCj/Y5zWXMO
	gRWdZLFoxbTx24KYkRyWOnzuuO+nnPwU=
X-Gm-Gg: AYBFou3Ud3JDjIne9buMGUEBIKzhdiUtRcbXR2EF1ecichB2Y2VlgWPv0VDZXbUoES8
	rqFVzUmi9+QbezO2xtPaAKF2BGCSudFidqHxB0ms700t74ojPhQkYPQiuZaZLel0tL2sYPIuu0q
	8iTXTICgztqeW7HExhayt6SoaxJ72mhqOPEBQRtqTwGuQxIqfMmZBBKXWTZSIza78fNvz53y3da
	W5U4f2bO0/yCu7BtB6toxEb04E6MPmQeBBBs/3+6ETWmAioo6SxXtH1F/mrDHpPLSj06LsfFEQi
	diH0mHfd1Z+ZGcgRelTgkw0rhntXu4s6pkUL+ujglYwzNnzJhTdpQQDeXnf2XCoykgPBTmcNiaE
	W07kPeoW3gtZoJISQzu5kswmcCYwCaopFH501ddofj3Eb8SW+qqViw63kRRIeOTG7N6jIIF6HRw
	B6VTu+28zi
X-Received: by 2002:a05:6102:5cc8:b0:7c3:874d:60bb with SMTP id
 ada2fe7eead31-7d072bc027emr2842138137.5.1793633396723; Mon, 02 Nov 2026
 07:29:56 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030161234.1505367-1-gourry@gourry.net> <CAN+CAwN+OPMPpVdBA+XtQvFpDy+EOY2TAiusxMjYR+r0F+MPhw@mail.gmail.com>
 <20261030164303.02c5cce0521c3d6fd4ddf015@linux-foundation.org>
In-Reply-To: <20261030164303.02c5cce0521c3d6fd4ddf015@linux-foundation.org>
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Mon, 2 Nov 2026 10:29:45 -0500
X-Gm-Features: AclHuK-onw5mfffqhDCdUvG-akV0FfaPCDY7vf1GKDjU7CU-jXjuRXPuiw8F_m8
Message-ID: <CAN+CAwOSz7BuPyd+u8KOitbDNFiDa0iNv+oFnQwbbt6kUw21PA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/mempolicy: recompute automatic interleave weights
 on memory hotplug
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, david@kernel.org, ziy@nvidia.com, rakie.kim@sk.com, 
	ying.huang@linux.alibaba.com, harry@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 7:43=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 30 Oct 2026 12:35:38 -0400 Joshua Hahn <joshua.hahnjy@gmail.com> =
wrote:
>
> > On Fri, Oct 30, 2026 at 12:12=E2=80=AFPM Gregory Price (Meta) <gourry@g=
ourry.net> wrote:
> > >
> > > In auto mode, weighted interleave derives each node's weight from its
> > > bandwidth, reduced over the nodes in N_MEMORY. HMAT and CXL report a
> > > node's bandwidth once, when the node first gains memory, and nothing
> > > else on the hotplug path recomputes the weights.
> > >
> > > This can result in a major skew in distribution and overload tiers
> > > with more data than their respective bandwidth can support, resulting
> > > in a performance regression.
> >
> > ...
> >
> > I think you may have dropped my review tag from the previous
> > version!!! I believe the only thing that changes is the warn, so
> > please feel free to add:
> > Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
>
> Actually, quite a lot changed, so dropping the v1 tags seems
> appropriate.

Hi Andrew,
Ah, thank you for the catch. Looking through the code again, I think
it still looks good to me so my review tag should stil stay. I'll be
more careful about stuff like this in the future!

> v1->v2:
>
>  mm/mempolicy.c |   36 ++++++++++++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 8 deletions(-)
>
> --- a/mm/mempolicy.c~mm-mempolicy-recompute-automatic-interleave-weights-=
on-memory-hotplug-v2
> +++ a/mm/mempolicy.c
> @@ -261,7 +261,11 @@ static int wi_state_refresh(void)
>         mutex_lock(&wi_state_lock);
>         old_wi_state =3D rcu_dereference_protected(wi_state,
>                                         lockdep_is_held(&wi_state_lock));
> -       /* NULL wi_state assumes auto=3Dtrue */
> +       /*
> +        * Hotplug events can arrive before any node reported its bandwid=
th,
> +        * leaving nothing to compute weights from. NULL wi_state assumes
> +        * auto=3Dtrue.
> +        */
>         if (!node_bw_table || (old_wi_state && !old_wi_state->mode_auto))=
 {
>                 mutex_unlock(&wi_state_lock);
>                 kfree(new_wi_state);
> @@ -302,6 +306,28 @@ int mempolicy_set_node_perf(unsigned int
>         return wi_state_refresh();
>  }
>
> +/*
> + * HMAT and CXL report a node's bandwidth only when it first gains memor=
y, so
> + * recompute the weights whenever N_MEMORY changes.
> + */
> +static int wi_state_node_notifier(struct notifier_block *nb,
> +                                 unsigned long action, void *data)
> +{
> +       struct node_notify *nn =3D data;
> +       int err;
> +
> +       if (action !=3D NODE_ADDED_FIRST_MEMORY &&
> +           action !=3D NODE_REMOVED_LAST_MEMORY)
> +               return NOTIFY_OK;
> +
> +       /* The hotplug is done, failing the notification would not undo i=
t */
> +       err =3D wi_state_refresh();
> +       if (err)
> +               pr_warn_once("failed to recompute weighted interleave wei=
ghts for node%d: %d\n",
> +                            nn->nid, err);
> +       return NOTIFY_OK;
> +}
> +
>  /**
>   * numa_nearest_node - Find nearest node by state
>   * @node: Node id to start the search
> @@ -3424,6 +3450,7 @@ void __init numa_policy_init(void)
>         if (do_set_mempolicy(MPOL_INTERLEAVE, 0, &interleave_nodes))
>                 pr_err("%s: interleaving failed\n", __func__);
>
> +       hotplug_node_notifier(wi_state_node_notifier, DEFAULT_CALLBACK_PR=
I);
>         check_numabalancing_enable();
>  }
>
> @@ -3910,15 +3937,8 @@ static int wi_node_notifier(struct notif
>         case NODE_REMOVED_LAST_MEMORY:
>                 sysfs_wi_node_delete(nid);
>                 break;
> -       default:
> -               return NOTIFY_OK;
>         }
>
> -       /*
> -        * HMAT and CXL report a node's bandwidth only when it first gain=
s
> -        * memory, so recompute the weights whenever N_MEMORY changes.
> -        */
> -       wi_state_refresh();
>         return NOTIFY_OK;
>  }
>
> _
>
