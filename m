Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34D02798EA
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790497949; cv=pass; b=dOQl3I2uBkHizVZJGbtvhjzINuUf4O+NYtisEWOrV4Pz4nNCnyqBOVy/A5RCeuvDYCJJ4zWzHwqL9ZU40aYSmNiwyvo0W81+OWdrbkdRVH4CQJZMoz4/9D5ZO92HtGT7N862B9Y6FO/0moOw+VDX/jT35s6Yes83nIQWzOmSkJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790497949; c=relaxed/simple;
	bh=Op4TF923PZN2pA1cGRLIOtwN+qOzyRIs41ZrhN5aXbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtmSeJJq+vwzbKrKvdOYrM62kfuf0pDFks+ud9QYrPAgX4hYWt94+du/H+w8mXh/n2u2C6gY8bHYCHPwUdR/jk3TvrNi8JJZWpM1Lg0ZpzkAHzmq9n7BlLnyX1diUMLiW4OEQJ1agWq/m95JbViJJaAXSLs8apBMvoKuaE5Kaxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbHon6ck; arc=pass smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbHon6ck"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ac6d9a3d50so55900a12.3
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 01:32:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790497946; cv=none;
        d=google.com; s=arc-20260327;
        b=sMouMazjx0iD4TIDUphvGbMIq8vCgYMwqZolj+MGNgncdNSpO2IuyoYTRCOSrw2ngy
         d5Yg0BzMQNxc/oc+64IGR+xaRlGGmjB3/+fEdKMr2SS2tkFSBU0W4zLreMtFZ5hCVtut
         NDy2jq3XiIYotqFDhMCncQZ4pYbACsOduS+JhiG6A7apr0NHg91aGKENcbgGQaK1fn1m
         KXE2gJP7kNTvQhoMEtZtpbIVJZ5gM4EyCEAzX2PMAm0fGGpoKMoRpP7AP8Q5gxOWgNym
         pl53KlsbjxCjcPJCWTa8hQO0jpfB0dszm4B2PIlvA0VnAUYMW5HM+u+KnSTXid82c4PD
         tFnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CUxHB4a9JqhTttVxs5UpiiqISs3GJlZ8HmVJ1p06eLc=;
        fh=mxNKXVXSxq3Hm34v+7qs3rdKl7ifAeDTKwcli2zPO4I=;
        b=q9r8riWWz992ds46UOUxvTXMOoMDAj/3BllSn+hgsL1YfAYINZIJ2+FmrF6y26faiw
         4Sj/04hWvnm2L3Zbbm9iLMumgzPWq+/HlYTlPZFLi7bXVC9i8g6LGcn+UH7Hgu6I7GJB
         jwBYKLB6jhZOHswuUFLkCyUyMYbYdD58TZA+/mxBI/247fZK02rkKhsfcsEvRLCVjN1g
         ctxx21HeODAaXfLWSzmsmW3G9lrwwFi1Nv5gjOC2rfnNI+hnAs3gdDKTYefT/vIUDgcO
         pxFD1S6G9CknXgbbhgQ6F4S/dUNAGuu/BRbOfzgaA3JKBOvku1wbGSFWNyH4CyIjzkPO
         jQsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790497946; x=1791102746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CUxHB4a9JqhTttVxs5UpiiqISs3GJlZ8HmVJ1p06eLc=;
        b=QbHon6ckRYMsI0mEyPG+ga7CzGgVyF9FopesfeHbDuuo+B0mBPtvABUOKpz8hHrE/Z
         22qbB19tDzgvAnm3sk92uOWUYPgEbSUNzUxoqRXAmK4x9BREZPTpQGoTxabyAaHVV9r6
         D1HVvCn3Wo3+faeCDEjgnnAyB5ZqCHA7UCom950omUPhW8ngruBHY4wTXlORoOg4IL97
         1z7sWPwwKcZ/m818pdG1nOc+4URg5oLu1wbC/cCrxPhy0Qd8BKth+H+rUdtyspPDT8fY
         UQpMFhN8nJSWBDrpSvdW3V5a7HOLYqLxRdRgyZNxvkOrKCwmQ6UiO4MFYFyRmcfUEkR1
         YKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790497946; x=1791102746;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CUxHB4a9JqhTttVxs5UpiiqISs3GJlZ8HmVJ1p06eLc=;
        b=K7d6YxQduJ6bHwJ5JIVY1yv6WI/XzyDi5N3C1hPX+6R3DcuKAtcXCrtw38CdV39cbi
         YWzi4xszraalluWoM15BtWkArPudrJjllBPNNMNCpyKZVyB/fIKbHdft3cB5ylKYUqK3
         j/D/nj50XDZJarQLx6YoXiEKb3egopYioPah/CG5DYtj+62AUyXwxlKlLec3yovDZPNy
         CVUsl3sn7KfZ8ij2mjSOOuPT38IxADDpCiPt2Zf0uy+bBv0mmDngXw2aD4V73h+6X5tO
         orDgaUQbO2JbLUeun3YSXnoRuVpVzFo8+d/HjkbLyMa2+jXxZ/XvGHxe5JtSKdlePMLb
         /W1A==
X-Forwarded-Encrypted: i=1; AKwUvBw58jU8Kb7Z0LSK1DxckVNmtDFvkNMLA0kOhdZqHbZiW5RtpiENECWbsl4tQuqOLKow1kHlqRE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkXOZJSDmsa0lovjio2z4ag4YcHgFBg2G8Cs9kOT2UTjNWqMB8
	NvXadSIGoh/vC2VvgtJJTdXavJ88SRsMddAzFDqPcFyVI+irUvQZmvUdp+GLHFzj8WIGIgB9HWh
	0shlSwzjhiWpzGW+HOBSOokjHs5A/FA8=
X-Gm-Gg: AYBFou2rOVFOpJtulPX02U4vXO5vE0ctXpYCuGXaIeqxTvE7gBzYkawUyKDO2+Bzn4p
	MVsx5JAEVKbgOr6EKhKBV3ba5WT366yWkc+ynGlD2S2Cnag4DLUcNSsyF1TbT+miOV5mv2Iec9x
	Y6sgsCrIfTXfKJ1zseVtGSvZ8obPieXGTa+xMi1Xd5XIS27sp4d0rvzSt8Uhiyh2uuoUTItGLat
	E+dyN/9QF9UomE0LWXotSKBa8L/1del6ESjHpEu/G3uFPmNYwp6OUVaOrbjDt7gwnZW7pT4nqPO
	/72VF2/O5VCr4kzdTnrwcQfLx5MSw2/ixPnCdb4twb8flr5UADS6g8JkjH+cA50TsSEV+YW774c
	uB6fD5Kz4d9AIrx8/cxRlZQ==
X-Received: by 2002:a05:6402:50c6:b0:6aa:f240:241 with SMTP id
 4fb4d7f45d1cf-6aaf24004c5mr4822258a12.0.1790497945733; Sun, 27 Sep 2026
 01:32:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926172600.2394088-1-nicoyip.dev@gmail.com> <179049714090.25414.9706892666916736240.b4-review@b4>
In-Reply-To: <179049714090.25414.9706892666916736240.b4-review@b4>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sun, 27 Sep 2026 16:32:14 +0800
X-Gm-Features: AclHuK-VVl8oMxw1DKEDd6CYLQdS-fllp6XQOLEY4IQxZkl62p2gPbF455zhrGI
Message-ID: <CAAo+4rXRTJz0wh=Xjv3ME8kfBsdgDC4q-n=M0-Z+uuOWik8fOg@mail.gmail.com>
Subject: Re: [PATCH net] batman-adv: Close OGM aggregation before transmission
To: Sven Eckelmann <sven@narfation.org>
Cc: Marek Lindner <marek.lindner@mailbox.org>, Simon Wunderlich <sw@simonwunderlich.de>, 
	Antonio Quartulli <antonio@mandelbit.com>, b.a.t.m.a.n@lists.open-mesh.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the quick review.

On Sun, Sep 27, 2026 at 4:19=E2=80=AFPM Sven Eckelmann <sven@narfation.org>=
 wrote:
>
> Thanks for the fix.
>
> Please don't submit batman-adv changes to netdev directly. And please sen=
d the
> patch also to the person which introduced the problem. You can use tools =
like
> `b4 prep --auto-to-cc` or just the underlying ./scripts/get_maintainer.pl
>
>     $ b4 mbox 20260926172600.2394088-1-nicoyip.dev@gmail.com
>     $ ./scripts/get_maintainer.pl 20260926172600.2394088-1-nicoyip.dev@gm=
ail.com.mbx
>     Marek Lindner <marek.lindner@mailbox.org> (maintainer:BATMAN ADVANCED=
)
>     Simon Wunderlich <sw@simonwunderlich.de> (maintainer:BATMAN ADVANCED,=
blamed_fixes:1/1=3D100%)
>     Antonio Quartulli <antonio@mandelbit.com> (maintainer:BATMAN ADVANCED=
)
>     Sven Eckelmann <sven@narfation.org> (maintainer:BATMAN ADVANCED,blame=
d_fixes:1/1=3D100%)
>     "Linus L=C3=BCssing" <linus.luessing@c0d3.blue> (blamed_fixes:1/1=3D1=
00%)
>     b.a.t.m.a.n@lists.open-mesh.org (moderated list:BATMAN ADVANCED)
>     linux-kernel@vger.kernel.org (open list)
>
> This change should not go directly to net.git. The target tree must be
> batadv.git

No problem, I will send the v2 to batadv.

>
>     $ ./scripts/get_maintainer.pl --scm 20260926172600.2394088-1-nicoyip.=
dev@gmail.com.mbx
>     [...]
>     git https://git.open-mesh.org/batadv.git
>     git git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>
> The last tree is irrelevant for you because it is really unlikely that Li=
nus
> Torvalds will apply your patch directly.
>
> > The OGM send worker leaves its forwarding packet on forw_bat_list until
> > after batadv_iv_ogm_emit() returns. Aggregation holds forw_bat_list_loc=
k,
> > but emission reads and clones the packet without that lock.
> >
> > CPU 0 can therefore start emitting a queued packet while CPU 1 takes th=
e
> > list lock, finds the same packet and appends another OGM. The sender ca=
n
> > observe the new packet length before the corresponding direct-link flag
> > is set, or clone the skb while its length and payload are being updated=
.
> > This can transmit an OGM with incorrect flags or inconsistent data.
> >
> > KCSAN reported:
> >
> >   BUG: KCSAN: data-race in batadv_iv_ogm_queue_add / batadv_iv_send_out=
standing_bat_ogm_packet
> >   write to 0xffff888100fedcf8 of 2 bytes by interrupt on cpu 1:
> >   read to 0xffff888100fedcf8 of 2 bytes by task 70 on cpu 2:
> >   value changed: 0x00c0 -> 0x00d8
>
> Is there a reproducer and where can I find it?

I will prepare one and send it right away. The KCSAN was triggered
with a kernel-side delay() instrumentation.

> > Set num_packets to BATADV_MAX_AGGREGATION_PACKETS under the list lock
> > before emission. This waits for any ongoing append and makes the existi=
ng
> > aggregation limit check reject further appends before inspecting mutabl=
e
> > OGM flags. Emission walks packet_len rather than num_packets, so the
> > queued contents are still sent normally. Keep the packet on the list so
> > interface purging can still wait for the worker and retain its existing
> > ownership of the packet when freeing it.
>
> I might be wrong but this reads a little bit like it was written by an LL=
M. If
> this is the case, please think about following the annotation style descr=
ibed
> in https://docs.kernel.org/process/coding-assistants.html

Yes, it was generated with gpt-6-Astra, and I will add the missing tag
on v2 following the doc.

> > Backports before Linux 6.15 need count-handling adaptation.
>
> This is wrong. You are depending on 434becf57bdc ("batman-adv: Limit numb=
er of
> aggregated packets directly") and not the counting adaption. Of course, f=
or
> 4.10.x-6.14.x, you also need to change the BATADV_MAX_AGGREGATION_PACKETS=
 to
> BITS_PER_TYPE(forw_packet->direct_link_flags)
> And it doesn't belong in the commit message (like this). Please annotate =
the
> dependencies as described in
> https://docs.kernel.org/process/stable-kernel-rules.html#stable-kernel-ru=
les
>
> > Fixes: 9b4aec647a92 ("batman-adv: fix rare race conditions on interface=
 removal")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> >
> > diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
> > index 53fbdbbe8f4f7..59847299a1237 100644
> > --- a/net/batman-adv/bat_iv_ogm.c
> > +++ b/net/batman-adv/bat_iv_ogm.c
> > @@ -1909,6 +1909,10 @@ static void batadv_iv_send_outstanding_bat_ogm_p=
acket(struct work_struct *work)
> >               goto out;
> >       }
> >
> > +     spin_lock_bh(&bat_priv->forw_bat_list_lock);
> > +     forw_packet->num_packets =3D BATADV_MAX_AGGREGATION_PACKETS;
> > +     spin_unlock_bh(&bat_priv->forw_bat_list_lock);
> > +
>
> Can you add a small comment above like "mark aggregate as full before for=
cing
> emit" (or something similar).

No problem, the commit message and the comment will be adjusted accordingly=
.

> --
> Sven Eckelmann <sven@narfation.org>
