Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607510;
	b=XpsyJZIjSj+TRv4Eulx0wQguoZdYS9F9xTUZiwMZJO0NCQsND34mDoV+m/b67m4S6SCJ
	 lFHiY/IsKn5jRqlaoHZjfizJEpGx6tMConAbPULwQCpvh+D9LAEAX8pqtoDp4NBt+4g8b
	 rQpRtS9VIpe+SbnvlXNd/DOazGoduIVT8nI9w0PR+iZHgY8qmyzQ7PVlz89C7ftDoHS+p
	 K7EAo8SFyf2RkubwPiRCBLgfwvstG30EMCEPWeBpk5cNkrTd/GZvF73TBCRdBGEY3B0j5
	 vZ66HW+glwugpjayW0syR/FIyiDEOGTVfh9olVQ/2y4mvQLTvDF3DMv2R72fNhkTMxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607510;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=LQ+/kIXsnEf+/yMaf4JHdayssXt0IvTFx291yCAqN0I=;
	b=4qwHCZLCiFQsHBZ51O6SgcqQgn80YQLWJXiAq4+d6WuQERpzI+tb+Gg8An3CXBb0W568
	 MHWCa2eHAkdtDOMLpE4SG7wTnethqQYAyYPiKbVwUPoW4v3VwvKpl2JPjubQFnn4jd8jp
	 z6VN5EiPtXgxpWRvB6irkVcp1P7BdztQI99s0lTYiBKS4iaw3b4VoRDAMbyCqM5t7te50
	 abryBEyYeEwNjdWLhVptSCOBaUieKZBFfFzqMcAz9COYAJN6iMDGCIhorAYS0pM5Xwknv
	 DHjoivmQ2S2omNAd0n/Zaa/uSjJbM009KTUdKfJRkSDbs2sUEN3DN39ll+cKchZZbgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=ekBqO5Sg;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9AB606A323;
	Fri, 13 Nov 2026 22:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF9AB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=ekBqO5Sg
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADLf47i3995318;
	Fri, 13 Nov 2026 14:05:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=LQ+/kIXsnEf
	+/yMaf4JHdayssXt0IvTFx291yCAqN0I=; b=ekBqO5SggzMgzbKwGyt6fptv864
	N4LXbRyW15gmC7gUWvXJowDX4G3SshEFUGxrLcJ88YQxmzIlA6I6/ee9yr6wJ5J8
	HjTl64VZy87KiwNYZzrp4TPSrpNMUmPiYxYZg7guX22S+flq6mVd4ITGOfFQ80S9
	dIBDXFP24JhurZG7iU8rFXoDspUxQmJSiryDhvvOHMV99QyCp+hiWmm0O8Dcydf8
	1QKueefN92sy0MNB7IIKliZIQsV+AP0a3yCrr8OgCO2ndjiV5PMwwvTCQ+nShgxO
	pkYru+XaO9VfsqOJGoiF0zSnICLZ1JQqTVBA5mfCz4NBCsujjhSglGl1ocA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hwkk9gbsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 13 Nov 2026 14:05:01 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1b::2d) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 13 Nov
 2026 22:05:00 +0000
Date: Fri, 13 Nov 2026 14:04:59 -0800
From: Bobby Eshleman <bobbyeshleman@meta.com>
To: Sergio Lopez <slp@redhat.com>
CC: Bryan Tan <bryan-bt.tan@broadcom.com>,
        Vishnu Dasa
	<vishnu.dasa@broadcom.com>,
        Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>,
        Stefano Garzarella
	<sgarzare@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        "Michael S. Tsirkin"
	<mst@redhat.com>, <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] vsock/vmci: reject datagram binds in local network
 namespaces
Message-ID: <aveJi+ehBghZ6/Fy@devvm29614.prn0.facebook.com>
References: <20261113-vsock-vmci-netns-isolation-v1-1-ced02054ea61@redhat.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261113-vsock-vmci-netns-isolation-v1-1-ced02054ea61@redhat.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA4NyBTYWx0ZWRfX8TSVGHeGuwZl
 DuiN1xwAtImumV8S+JQqecYnRC9HjIXqdRVRCkZWaR8chGd7+vreV74cGajVcMFvc6E9Kkk/RkI
 2PrOKX1JNjXBsQyfYXM5iVUkTcQu4IuLOERUgfFkhf4P8xdoY7Ys8pyyw5j/muVowq6CtFKwjkP
 FyCQPBlToG/ZTQdQvEMN4beKoAJp6VCR7Sb5deM/lvBuafUXGCB4jmgJqvoFS9vtpLbzm8OWPNl
 lNFr43hJ725oauVwaH83ujXfYItfoEO78vvrWjIdhUOsi2JonK0so/gHKLy+6p7UOnN9Ou2sAjv
 4/6VEvro5MeasKjM3dvHOtwtf4ctf1iutFPNwG9Hfz9P8LfeCZ2W3oA+6RAMyWZF2imYoVKOJWE
 69i6MVeVGU01Ino+ESnuocuHTDcJFPih1DRX2sf2wSbDKO1yZQE3mPwH3NO3L435lBNdkTG3gCB
 SCzTK1k/8Wzsz2Y2ypA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA4NyBTYWx0ZWRfXxA+5hsMAS/Sp
 t4lE80PUamLj5rfnGSQuH8pd76cq+ZESQiz54zQdq6OltbWek9T1KVNiffACqO5QZCvx6ZDXrHg
 bhxJq0ztWIb6nrWFRzrFBxfEYvSvDa0=
X-Proofpoint-GUID: 3Di65TljFpEGONzW2DDRCtPX2nAP-ZZQ
X-Proofpoint-ORIG-GUID: 3Di65TljFpEGONzW2DDRCtPX2nAP-ZZQ
X-Authority-Analysis: v=2.4 cv=GrXXaU1C c=1 sm=1 tr=0 ts=6af7898d cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=4h92JMTCafKA-fb_NiOh:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VabnemYjAAAA:8 a=i7-SfpROG94AJB53qLoA:9 a=CjuIK1q_8ugA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_06,2026-11-11_03,2025-10-01_01

On Fri, Nov 13, 2026 at 06:04:40PM +0100, Sergio Lopez wrote:
> VMCI already rejects datagram sends from local network namespaces, but a
> datagram bind still creates a receive handle in VMCI's global port space.
> A VMCI sender outside the namespace can therefore deliver to the local
> socket. Its handle also prevents a global-namespace socket from binding
> the same port.
> 
> Reject VMCI datagram binds in local namespaces. No namespace-local
> datagram transport exists, so EOPNOTSUPP reflects the available receive
> paths. The receive callback also rejects any local-mode socket as a
> defensive check.
> 
> In a KASAN/lockdep QEMU guest, a reproducer observed cross-namespace
> delivery and the global port collision before the fix. After the fix,
> local bind returns EOPNOTSUPP, the global bind succeeds, and a global
> VMCI datagram still reaches the global socket.
> 
> Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/sashiko-outbox-212907@kernel.org/
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  net/vmw_vsock/vmci_transport.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index 1f186e8f8364..282131544c42 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -627,6 +627,8 @@ static int vmci_transport_recv_dgram_cb(void *data, struct vmci_datagram *dg)
>  	 * outside of the create and destruct socket functions.
>  	 */
>  	vsk = vsock_sk(sk);
> +	if (!vsock_net_mode_global(vsk))
> +		return VMCI_ERROR_NO_ACCESS;
>  	if (!vmci_transport_allow_dgram(vsk, dg->src.context))
>  		return VMCI_ERROR_NO_ACCESS;
>  
> @@ -1697,6 +1699,10 @@ static int vmci_transport_dgram_bind(struct vsock_sock *vsk,
>  	u32 flags;
>  	int err;
>  
> +	/* VMCI handles are global and cannot serve local namespaces. */
> +	if (!vsock_net_mode_global(vsk))
> +		return -EOPNOTSUPP;
> +
>  	/* VMCI will select a resource ID for us if we provide
>  	 * VMCI_INVALID_ID.
>  	 */
> 
> ---
> base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
> change-id: 20261113-vsock-vmci-netns-isolation-7e46732dcd73
> 
> Best regards,
> -- 
> Sergio Lopez <slp@redhat.com>
> 

Acked-by: Bobby Eshleman <bobbyeshleman@meta.com>
