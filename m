Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AE454489A
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 21:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112983; cv=pass; b=d1tRPtmxZ5GP3D63VSyc3jIXVFdCZkocl1x9d4z7RQGuGSimL0f5JWUo+K5Ym5enQs+oD3d9VI4Frjo0aAPzfri9trW5fmmfxJE2MVvF12SrAqBwNUPWI6yET4vV+w+8Lqx6B3dAphRSqT/DkXa//q7QkjPyJ2UpsZI09pWaomk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112983; c=relaxed/simple;
	bh=aZGKfL3QuDsd4IV/LQDvu27JhAeZANTouNPDY3sRBkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGPO0cUHs7/MQpxvtwg1XnbuGGEd9hoMNOxlHLY2wtuJcy01Ctfg5xUmubr9uo1rOCiaJSlMuwpUW+WmsI1+dUGqqRfsEmPJPgw66NZkVgrxlCVfY0O9wdIVpATe9MFXvkt0pTKNX3kR1WZRCfWvWhqkLX3d/kdZ/4QgZqZGTks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=DnqNkRhM; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="DnqNkRhM"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469b35611so203254b3a.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 14:36:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790112977; cv=none;
        d=google.com; s=arc-20260327;
        b=Dh3hqt0nlhu0uMCAYWth4XG8UL87ptlJ3bJmvamFd0xXW7srzMb4Df9bfuD2pKDgY3
         HhdhDgwvd4qtlxbRJsfYAcA6a9MIRzEXdaIE2Kx+8QsE2dSoFmEqFCFwpooU3F7PeMFi
         caCejwEgaJdZmX32wjSO83GbBcz4SmTvlD+zV4pK9nAZ1oFGBlrgeLAGtNXjwxHOyhm5
         oDx319cvADQEzA1XK7hNbyJH7o760ouojX8FSgoCW4APzXBRWv/prGI64RWJn0i7X0Bz
         EidrYCBWSsvMp1J1nQNxMpJzL3V+GDqEoVEWCIb4pk9uxv6rzRiUSlIPyUcC2ryEuJ1T
         huWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wfpSlvWpUl0lvkt+6Kff0Lj6e10Ks5VeX4xVd+zNn48=;
        fh=Fw4bbuOP0PCOylIusnH7WscElIEG72R/scWXBWej/Y8=;
        b=lTlh8CfxS0FgVR7EYlFG+k0FweK8Qw/AnTSr6ESipU+tqR+/qGxRTZHLMeP9QuVnj1
         Ew+v6baSFEsB6UknsIiQBURUXzhgCtibK79IHDrX8a3nz43EFO/t85DCLUZSlNGJNwYR
         eHu9JizQ77LaDvAHLicKRYgignGGLZH+vU2Pk1p5Eqrih9IWT/nE8G+GPph+16KYGiFv
         y+IxRWnaTaGSGp74aP+tB5uRCKK03CXGIv1JNVkdDksNzuKJvdsI+W8zIy0Dh0tFbhdP
         ajQJXM+OtVZyWLVMFZ0MS6syJuiA67kYrRMHEzPW8rHcu2JnHuX7RSH9MWBkQ09MQFrx
         wIjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790112977; x=1790717777; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wfpSlvWpUl0lvkt+6Kff0Lj6e10Ks5VeX4xVd+zNn48=;
        b=DnqNkRhMANDAbz8S5xGFlfWPA4TC6HEBdoloJTzkhG4LfCrEPYGEKtpT/8TOc+jc+K
         kZvWarBK8zOodWUKLeMNCiGOEM0hQh2wzWAUI2U9ZL78Shhz7CSiDe/oWd5nFcvAnZ9L
         CIafMBSlVa1Q0EWrcXq706DUipXzYhPHoezVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790112977; x=1790717777;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wfpSlvWpUl0lvkt+6Kff0Lj6e10Ks5VeX4xVd+zNn48=;
        b=SmwRIzDGo8HL554j0B4Wnx6lWmBOkWz514jAYCZSOeKvxN7zrqaQn6cHMfRaBn6pDb
         rpu68/40BLs2AvrWo0NQR08KzPnL3r/8HbY48bjG442Vh6KTenW/E2jNyfIs3MFidqXo
         SsCOxvJHeie9cNc6Jxsmd+Uo7ENBenFYnD61IZnSEnd4xPUZa/s7u/cyHSkNaHyE20dF
         K1yxOiopf9Wcwn5lELDI+AF8qpB0emwoqVIzG27jiSugFjHMF01NfZuqxWaQTr+NyHbV
         QC51TS0mY6z5V7JE9uQyhEbZwJ9l6WdsM7wj5jmsBEvNLASa2T99JVV1Vn4lMadIWpwB
         AHwQ==
X-Forwarded-Encrypted: i=1; AKwUvBzf3PWtxU5e2qrZKhIxBMS+NXqy6EQNrAg4zaYMIhexiBS/VllnrpMRij2FtW/AMJClKN2JugE=@vger.kernel.org
X-Gm-Message-State: AFuF++k21p62w2KGXbtOUIqxcA9+nL9hBbfap7BtUcPj61A9WTs0IVSs
	Ficbmd+7SGqhO46xICSMZbj8ta8n/uYP5T96YT6rE1cMkbRgfj5TQ3V6Vhuigb07FkLfH7J8nyW
	fHU/tvWlQ3HqD98QhzCFSB4oBByPD5dJnVKR4TcxO
X-Gm-Gg: AYBFou3ePBmYo8G1U6NxCjQsiOWI27Mrw9/nUX7IFy3vGvRaKz4GckOxKmluUUV+91c
	0mtPCcl5UIsTyhAnWZ2UrVk+crZMwDDMthH1++J8TXaIHOAeBNiF1QUInoxS0Jk3pyDkEjOU8q+
	EBTwN+l/L+uURzjGlX/lqJ6jRycVfG+W6naKSlnwAtIszoBCGlKgy7dMfslOjKQ4qjM6sn6/oqf
	hqyy4YkpRr95tUDFqJAK17U3ZkohBhEEE/2xJ0dPimro5LM16Htdt20jRq1B+qKEg4erbc8E0AQ
	rOIuuYGm3eOrX2A5+X8z6IURQxFP9Kq+e4thgpvQGQW15yd6zCdOH3AdgwRwF0Jv6vu3KlxGUJ4
	zAYll3C9nCjgSAN7MnQGKOGC5w/9Yu7oagQ==
X-Received: by 2002:a05:6a00:4099:b0:86d:3958:6b13 with SMTP id
 d2e1a72fcca58-87d1b0c0ee7mr833702b3a.19.1790112977303; Tue, 22 Sep 2026
 14:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921145655.3167436-1-i.maximets@ovn.org> <20260921145655.3167436-7-i.maximets@ovn.org>
In-Reply-To: <20260921145655.3167436-7-i.maximets@ovn.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 22 Sep 2026 17:36:05 -0400
X-Gm-Features: AcwNN1WkTM90t4zAGVak1fLnVY1e6J2lGuTsKVieqJYWq0WRhgHFKVnTUE18TSw
Message-ID: <CAM0EoMmF8KE2m0B8rON8iOcaQAHWMSS6G=CkOdwh9snaTzvNpw@mail.gmail.com>
Subject: Re: [PATCH net 6/6] net/sched: act_ct: fix helper UAF due to
 extensions realloc
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Xin Long <lucien.xin@gmail.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, linux-kernel@vger.kernel.org, dev@openvswitch.org, 
	stable@vger.kernel.org, Axel Mierczuk <axel.mierczuk@1password.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 10:57=E2=80=AFAM Ilya Maximets <i.maximets@ovn.org>=
 wrote:
>
> While calling the helpers, a raw pointer to the extensions area is
> wired into expectations list:
>
>   -> nf_ct_helper()
>    -> helper->help()
>     -> nf_ct_expect_related_report()
>      -> nf_ct_expect_insert()
>       -> hlist_add_head_rcu(&exp->lnode, &master_help->expectations)
>
> In case the connection is not confirmed yet, more extensions can be
> added afterwards with *_ext_add() calls reallocating the extension
> space and leaving the now invalid pointer in the expectations list
> that is later accessed while removing the expectation.
>
> Make sure that helpers are called at the end after all the other
> extensions are already added.
>
> Note that the helper rejection now leaves the mark and labels set,
> but that's not different from how the NAT was handled before or how
> the mark and the labels were handled on confirmation failure.  And
> there are no atomicity guarantees provided by the API anyway.
>
> Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
> Cc: stable@vger.kernel.org
> Reported-by: Axel Mierczuk <axel.mierczuk@1password.com>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  net/sched/act_ct.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index f62051ec9d57d..411e3dd92d072 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -1102,19 +1102,25 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *=
skb, const struct tc_action *a,
>                 }
>         }
>
> -       if (nf_ct_is_confirmed(ct) ? (!cached && !skip_add) : commit) {
> -               err =3D nf_ct_helper(skb, ct, ctinfo, family);
> -               if (err !=3D NF_ACCEPT)
> -                       goto nf_error;
> -       }
> -
>         if (commit) {
>                 tcf_ct_act_set_mark(ct, p->mark, p->mark_mask);
>                 tcf_ct_act_set_labels(ct, p->labels, p->labels_mask);
>
>                 if (!nf_ct_is_confirmed(ct))
>                         nf_conn_act_ct_ext_add(skb, ct, ctinfo);
> +       }
>
> +       /* Run helpers for the connection if nf_conntrack_in() was execut=
ed
> +        * or if we're about to commit.  This has to be done after all th=
e
> +        * extensions are already added.
> +        */
> +       if (nf_ct_is_confirmed(ct) ? (!cached && !skip_add) : commit) {
> +               err =3D nf_ct_helper(skb, ct, ctinfo, family);
> +               if (err !=3D NF_ACCEPT)
> +                       goto nf_error;
> +       }
> +
> +       if (commit) {
>                 /* This will take care of sending queued events
>                  * even if the connection is already confirmed.
>                  */
> --
> 2.55.0
>
