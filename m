Received: from outbound.st.icloud.com (p-east2-cluster2-host7-snip4-7.eps.apple.com [57.103.78.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890D4272E7C
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 04:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780288705; cv=none; b=bGP7fDz4VkDAdF5HStRg4Xl8sRRfosxIX2O6X1RQ9QX9ZzCcTx3gNavTsPflDEno9lG3qv63ABxNe4aY6cOPNrG819Ju0y7zj9A/PI832PWYYJwt48rP3V3aOKFuFJPUKXFX4/P5fGhrYho1GA9cCU4UyC3zBux+T6cz7WtW+K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780288705; c=relaxed/simple;
	bh=M5KXcHZLLCjiSOAXT/6Zty8mqvZnR+CJHcL1M48YmZg=;
	h=Content-Type:From:Mime-Version:Date:Message-Id:Cc:To; b=JOO1n9cwGBmTJSBveJDQgFVsI1C7U9gGKIsUQzlm+fQOkpNm8C6ym5J5lH1UwpNf8NRrDd93Iz5UEtAAPIF9wgD/LmOTqDcwP0SE4UQNrHf8OvArZDBhfB/fM/5F8txnKw1bsfGOkzfS/kHjsCeCuE/+LPpY9lfZ0UE7XwDbiVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=p7RM5uWB; arc=none smtp.client-ip=57.103.78.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="p7RM5uWB"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-20-percent-1 (Postfix) with ESMTPS id 49107180035B;
	Mon, 01 Jun 2026 04:38:19 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhACkMFWwFeCEgFQwZeAFBcHA4OXxlbAxcfRghFGVcCVkgEVAIrWxNVF0YJGQhdHRkeV1BeCF4fTBwdDlgGEgJaRQJZFwNXHFZFXBhDCV0FVxwdHkNFWxNVF0YJGQhdHRkIRx8KMANCDlYDQwdFAC0ZHFdQXgheH0wcHQ5YBhIdUBwOUXIvCkcBPAFaGltxNHtVB1wGWB8xD0wLQHYuBkZ8OXBZASoDNHkRUAFYHlZeWhdeUxcfSwBcRVoOWwRHFA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1780288701; x=1782880701; bh=8HjiOho8L2jW+i0Jru4sQZRWcNoS66uzGYMY1giqctw=; h=Content-Type:From:Mime-Version:Date:Message-Id:To:x-icloud-hme; b=p7RM5uWBL+MIGMX8hVmyvr1btwE4BTJ1Z+qG+aHhVPcIqBI//Rm+IkIOCkeQ6fy5IXUd3v+ks3fgLqMiQZJh8BLy6PDyXL4At3Skh3LHNkfgsaREqQ34mhcmrnoiH9RVLKmVDc3TZBpKVUZFiNfK8IA5fga6A3AmwJqlABDiZS4xJ1CYezpG5xIHxQKh4y4uzj+32JQofU//wC7xrCiQAzjtoNlFh2sCwhtQXDmG1AJ+Au/sIaivuYmHxwD8GbxeCZLfz0oFFaa4tZjZHwvdh9gVpy9ckRIAipTwnrFPHEkrCySGtm8oRgIc4N6j2HKVkz9nnTPsGr5jvIPi89CuMw==
Received: from smtpclient.apple (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-20-percent-1 (Postfix) with ESMTPSA id 9C3661800176;
	Mon, 01 Jun 2026 04:38:18 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Christian C Guerrero <chris.guerrero0795@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sun, 31 May 2026 22:38:15 -0600
Message-Id: <ED878D27-0CDB-4113-A648-AE46EAC46A1D@icloud.com>
Cc: Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Abeni Paolo <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
 Matthieu Baerts <matttbe@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
X-Mailer: iPhone Mail (23F77)
X-Proofpoint-GUID: Nle5phvKo13CcyuSwDi8Wvtyg11rnvbW
X-Authority-Info-Out: v=2.4 cv=E9fAZKdl c=1 sm=1 tr=0 ts=6a1d0cbc
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=x7bEGLp0ZPQA:10 a=tn3to7fOw0sA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=KZnKJZhHIq7TdMh2gb4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA0NCBTYWx0ZWRfXx6MmOzvelBFU
 K7e5nQMShm6ZI8yvEO9dySU9jr/YBSpxu0FMYDj/rTTVu6MxUxvy0TN1gPqEVZMAvjE1x2iQOnV
 GD7xuuhdyJPJXHVjmrM+1p6FOHXAqu4hPgVTIl4L/Uz7ad9tp9VTWkdlrQ2piGF48p90cxqgK7v
 Y1hAV3M2n/PpfT8zIkUP5hOaKIRptgSbm70HVhQKPJzF456O9mx32t2/LIRaTX7TbSA7xmgGFvE
 D/wcTUCcHhRTboUkoEU2qfF9A5BIUtuCiOh2jPoWgkska2bXfKRxvFiWCY9OcHQnbJAn95ma2So
 APN0ywtHBeBzjtbt6wpwCHxxAC5mOOcJLoKr2RReYJhNkPJP61aA92SHdm8WZo=
X-Proofpoint-ORIG-GUID: Nle5phvKo13CcyuSwDi8Wvtyg11rnvbW


> On May 31, 2026, at 9:11=E2=80=AFPM, Matthieu Baerts (NGI0) <matttbe@kerne=
l.org> wrote:
>=20
> =EF=BB=BFFrom: Paolo Abeni <pabeni@redhat.com>
>=20
> The MPTCP output path access locklessly the MPTCP-level ack_seq
> in multiple times, using possibly different values for the data_ack
> in the DSS option and to compute the announced rcv wnd for the same
> packet.
>=20
> Refactor the cote to avoid inconsistencies which may confuse the
> peer. Also ensure that the MPTCP level rcv wnd is updated only when
> the egress packet actually contains a DSS ack.
>=20
> Fixes: fa3fe2b15031 ("mptcp: track window announced to peer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/mptcp/options.c | 36 ++++++++++++++++++------------------
> 1 file changed, 18 insertions(+), 18 deletions(-)
>=20
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 8a1c5698983c..5c228344e83f 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -570,7 +570,6 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
>    struct mptcp_ext *mpext;
>    unsigned int ack_size;
>    bool ret =3D false;
> -    u64 ack_seq;
>=20
>    opts->csum_reqd =3D READ_ONCE(msk->csum_enabled);
>    mpext =3D skb ? mptcp_get_ext(skb) : NULL;
> @@ -601,14 +600,11 @@ static bool mptcp_established_options_dss(struct soc=
k *sk, struct sk_buff *skb,
>        return ret;
>    }
>=20
> -    ack_seq =3D READ_ONCE(msk->ack_seq);
>    if (READ_ONCE(msk->use_64bit_ack)) {
>        ack_size =3D TCPOLEN_MPTCP_DSS_ACK64;
> -        opts->ext_copy.data_ack =3D ack_seq;
>        opts->ext_copy.ack64 =3D 1;
>    } else {
>        ack_size =3D TCPOLEN_MPTCP_DSS_ACK32;
> -        opts->ext_copy.data_ack32 =3D (uint32_t)ack_seq;
>        opts->ext_copy.ack64 =3D 0;
>    }
>    opts->ext_copy.use_ack =3D 1;
> @@ -1297,19 +1293,14 @@ bool mptcp_incoming_options(struct sock *sk, struc=
t sk_buff *skb)
>    return true;
> }
>=20
> -static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
> +static u64 mptcp_set_rwin(struct mptcp_sock *msk, struct tcp_sock *tp,
> +              struct tcphdr *th, u64 ack_seq)
> {
>    const struct sock *ssk =3D (const struct sock *)tp;
> -    struct mptcp_subflow_context *subflow;
> -    u64 ack_seq, rcv_wnd_old, rcv_wnd_new;
> -    struct mptcp_sock *msk;
> +    u64 rcv_wnd_old, rcv_wnd_new;
>    u32 new_win;
>    u64 win;
>=20
> -    subflow =3D mptcp_subflow_ctx(ssk);
> -    msk =3D mptcp_sk(subflow->conn);
> -
> -    ack_seq =3D READ_ONCE(msk->ack_seq);
>    rcv_wnd_new =3D ack_seq + tp->rcv_wnd;
>=20
>    rcv_wnd_old =3D atomic64_read(&msk->rcv_wnd_sent);
> @@ -1362,7 +1353,7 @@ static void mptcp_set_rwin(struct tcp_sock *tp, stru=
ct tcphdr *th)
>=20
> update_wspace:
>    WRITE_ONCE(msk->old_wspace, tp->rcv_wnd);
> -    subflow->rcv_wnd_sent =3D rcv_wnd_new;
> +    return rcv_wnd_new;
> }
>=20
> static void mptcp_track_rwin(struct tcp_sock *tp)
> @@ -1474,13 +1465,25 @@ void mptcp_write_options(struct tcphdr *th, __be32=
 *ptr, struct tcp_sock *tp,
>        *ptr++ =3D mptcp_option(MPTCPOPT_DSS, len, 0, flags);
>=20
>        if (mpext->use_ack) {
> +            struct mptcp_sock *msk;
> +            u64 ack_seq;
> +
> +            /* DSS option is set only by mptcp_established_option,
> +             * the caller is __tcp_transmit_skb() and ssk is always
> +             * not NULL.
> +             */
> +            subflow =3D mptcp_subflow_ctx(ssk);
> +            msk =3D mptcp_sk(subflow->conn);
> +            ack_seq =3D READ_ONCE(msk->ack_seq);
>            if (mpext->ack64) {
> -                put_unaligned_be64(mpext->data_ack, ptr);
> +                put_unaligned_be64(ack_seq, ptr);
>                ptr +=3D 2;
>            } else {
> -                put_unaligned_be32(mpext->data_ack32, ptr);
> +                put_unaligned_be32(ack_seq, ptr);
>                ptr +=3D 1;
>            }
> +            subflow->rcv_wnd_sent =3D mptcp_set_rwin(msk, tp, th,
> +                                   ack_seq);
>        }
>=20
>        if (mpext->use_map) {
> @@ -1708,9 +1711,6 @@ void mptcp_write_options(struct tcphdr *th, __be32 *=
ptr, struct tcp_sock *tp,
>            i +=3D 4;
>        }
>    }
> -
> -    if (tp)
> -        mptcp_set_rwin(tp, th);
> }
>=20
> __be32 mptcp_get_reset_option(const struct sk_buff *skb)
>=20
> --
> 2.53.0
>=20
>=20
