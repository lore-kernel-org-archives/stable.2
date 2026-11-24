Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795539145;
	b=R50Qi5Z7wAfnAWdXOUiQt2ve9Jlly3KNpOo0ip1TmfdwL2WWURqFxkQa358f11WIDiSt
	 tyJz7iZDzPHmIL72+jJQq6UTMbelylsE7kgRRZCE3yRn4VXk8frIb4ctL476pHgnJK92C
	 Y0op7m7jupvY1Gq9e8VMuJVa5FCROV2ljAL/flCYrjxKXi9X9wun0ucz1eGfMQKkA/cDP
	 YB36/ilZgOHfGHP8yz0ss0YMHy5agPT3ZZWm3J+0PVC5U9BVtUTPkk67EkUFRH8104oK1
	 cSwKgUXq6/XNIagmBsds8L5inhGK7DIZrwmc3Fon6VPZMnwEexjkUl2/N2v+rHNG0gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795539145;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=e9/oR9mWS1WKPmGomi/5W0W8MOD9LULGfpTOrsM0bLc=;
	b=DaeC294v1e4JtLqXCQ4KeSgCnqPfLl6ziA0gxBTE+VlGcbUcVHIKcdQa/qEGLCP+DCsZ
	 bFS0rClJGGz2RWnSWmewnPTUyoAPln8ArN5OXAfU3B0ExH4zt7p+JYh91WQfUYZkpz0WW
	 aGbOljgGesh3EAkCvMSnr1S1cucO7dy/BYAigeOosDzEchbytFN6TNVvngzX1Zsc4U4pD
	 oMEmUo3mQ7hmiyBDKL/zLvfVDpOwH1JA3Ms4dYvVf/mjq5eyj3v5xCZTis/waRM51RpV1
	 D7kZNDmWnIJLSZs5WesqOzkory/Q+sTlivkQ3lGu7cRwUbyyos+uy/OV6u/7ppOIbZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tt+Z3qyS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528A4606A33B
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tt+Z3qyS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9015D1F00A01;
	Tue, 24 Nov 2026 16:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795539144;
	bh=e9/oR9mWS1WKPmGomi/5W0W8MOD9LULGfpTOrsM0bLc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Tt+Z3qySazQDNevtcIVFUXsucoVNkegboHtm4If/WUHepEuG3qv9Tm49ecaATePMT
	 xxXfeCz98cQ3IbXJUgoMjC+NUfbykaS+iutN9nQ6yXSw52Yn0JKEwmL6dlSqXkLtb5
	 Ic8kAH4G39gDmFLrn4NUKun9rB90W3x3RGp0uN7kawYw+9o/5B0FT1z3C5gwKKnZVS
	 eNAx4ZfT6UitW5sqcCI5oUvDoGOvB6A9NqskO8D02Seas3iJCuL2AwdcHH/mGsDOD8
	 arxaVU72AI4guMHEu1CTHwZcOk/vXeUCFNc7MTbSWMPOXj4VP6MfCNKzx+nHQ5rx40
	 DIsqTCuqF9T5Q==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7D259F40066;
	Tue, 24 Nov 2026 11:52:23 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 24 Nov 2026 11:52:23 -0500
X-ME-Sender: <xms:x8AFa0JvY8eIhhhuqEEGFPYZYeE5SH4sMYrcY5WFCogeGX64IB5utw>
    <xme:x8AFa-9-suNJopYKr85HOjeHYXllf0uiMrmtUbm4THOU1sHLYzE-HTdjn5CBrPdqA
    HDXOigWeDKQJ2VUK5SBgLHPH4TJr3X6VdFqJyqvKqrUtl2MpGkWSRM>
X-ME-Proxy-Cause: dmFkZTFvffRiS/ihXQ+YlJikK6/tQ9o9zou164jyx6LFNSPLtLOpM/z5pCkpE2k7W5A3uY
    +dtSa7IoGmWq+8CMRVel6H4toMv+YitB6FZdwMpEDoazElCpx7m2KIlcpn2sL7NohjG0Yq
    WvJdSa1jfUXhcEojoCwPdW4vT/1LueE5TbPt7GryfKu+nNw4pddnqHDAUe4SUTvPZ3Y2T/
    42PewF4uInOOZu4uOgiCJre05f2aQr54265zJnw7xRS2eSB/NRaaX2/MSNa8dzZEGFsbSr
    chZtgtOh3e1Az8tqkIgzb0HJKtQ+PBlZ5J4RGZ0Fmdty3rtOTzVZeGFIokBDDZ8j039OXC
    K+vyK2cu7Go+E9WkYANqiHpGQhIKl6UsZD4Fk0Xvh9x4C9d1BF+YusJV7/hcbnmlYsVRWa
    v7cEouQoimmSnscH4TsZPo5Gs+GToxlmoX4ZifoAD7F3KRtSs9r+YTAtSFeMRjzArKLkRk
    3EF2r4jiFjIdv8jxpexdM2doAvbGVCUNPgqTUxB6LAMRdN/w+YNM59VmvJ0sBMwHjhF608
    HVqNUnEuyrDD07bPcdLaoqDir+/Xw5Js9nUthGb8OOyLduKdxdBH3cHKabdAjQd4GJzbpt
    Zxi4Fsu34vPtZ4SM66WKD7bsfI6F/fRT+9BJPvIGaDfBuPVz4rWyRGNAv3Sg
X-ME-Proxy: <xmx:x8AFa4YpndLo0kCYSEOENU5U8F7agU7DYGm_X-RBfOgSzVC7kbByuw>
    <xmx:x8AFa_yRoZz0IKTZpY5nhhbU-8zI9sq4LFih-wGEqoViJ1RziplYag>
    <xmx:x8AFa3Yh_zjshc_CDNFtEik9ECnVmJlV9qOT3OTutJM_7Up6PZ4x_A>
    <xmx:x8AFawxYrjCHo7Hf8ABGNsBTQeOXPu1uVyW0xkCUGksK8Is2dLVLDw>
    <xmx:x8AFawHlLJ1rJI-As23fi1xTxX1CPxcu8lRrulIZhNFmTILUPWSCvVh7>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 53CB4780070; Tue, 24 Nov 2026 11:52:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AK3k8V--uDCJ
Date: Tue, 24 Nov 2026 11:52:03 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Li Xiasong" <lixiasong1@huawei.com>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
 stable@vger.kernel.org, yuehaibing@huawei.com, zhangchangzhong@huawei.com,
 weiyongjun1@huawei.com
Message-Id: <187e2fd0-165a-4dc5-a542-6d87d4750bf7@app.fastmail.com>
In-Reply-To: <20261124021842.130141-2-lixiasong1@huawei.com>
References: <20261124021842.130141-1-lixiasong1@huawei.com>
 <20261124021842.130141-2-lixiasong1@huawei.com>
Subject: Re: [PATCH v3 1/3] rpcrdma: Serialize notification registration with device
 removal
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Mon, Nov 23, 2026, at 9:18 PM, Li Xiasong wrote:
> Registration can race with device removal between the client-data
> lookup, the removing-state check, XArray publication and device
> reference acquisition. Serialize these operations and client-data
> teardown with a module-wide mutex, keeping callbacks and completion
> waits outside it.
>
> Enter a NOIO allocation scope before taking the mutex to prevent reclaim
> from waiting for RPC I/O on a transport whose reconnect needs the same
> mutex.
>
> Fixes: 7e86845a0346 ("rpcrdma: Implement generic device removal")
> Signed-off-by: Li Xiasong <lixiasong1@huawei.com>

> @@ -187,8 +209,11 @@ static void rpcrdma_remove_one(struct ib_device *device,
>  	}
> 
>  	trace_rpcrdma_client_remove_one_done(device);
> +	mutex_lock(&rpcrdma_device_mutex);
> +	ib_set_client_data(device, &rpcrdma_ib_client, NULL);
>  	xa_destroy(&rd->rd_xa);
>  	kfree(rd);
> +	mutex_unlock(&rpcrdma_device_mutex);
>  }

Nit: The conventional practice in the kernel is to release resources outside
the mutex. AFAICT that is safe to do so here; only the ib_set_client_data()
call needs serialization.


-- 
Chuck Lever
