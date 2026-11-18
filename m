Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795040254;
	b=1zMwfoWb4duT03O2KELRi2lejIvlzpP0D8iac2ptE8lzk+zFwO44cUH4BkadKObKXCNx
	 bwB4S1elFNSzmrAEXyGcvCnKWAI0tHkni2q8IA2XQNyLcO6Xih0VGnAY2+se51IL64Pqm
	 BjN89g0tG1D220Aj4QFg2zlu/LcC0KoJkqHnXwI36GvJx5H+OFqCkouyKKOrrt2yAaQIC
	 75HCZyBcYJehN11trDOdUlavoPoB+ZSxtjCICohDGK+N/iQabwtg0l67y2I5xA+TERQHZ
	 HjuStEXXmxtZ2Y40X9K+lMXRAeK2YQhy6wfSh/zeiHP059hmbmmh60HqzzjEl95CjuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795040254;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Sfi+v9RXU9y6hjj5yrpY0/fvAILO6daDnKEy+gfCKSs=;
	b=hDq+dgmlffkseUOlQWDHmv8+KU0CPjXDFCsHYqF4k7E/ijtT3J9LR+6hGliW+L6T9OmW
	 ezJHqlte13MpGn1fLRvwH5Dv462LpzUoGTlgyKtRXjA2MSqcSsBitrT5x8IY5gJe6W6qw
	 b0TeRavaY+U4Nt5xCV81EV73JEjp5u1ubOxAkZTX7+p7WGMIaBya93RpvZ2zHpQvZ0Rzm
	 G+C4ueGdLelNsinD/e4EJigYgf0ejBE8VlzouhgvSt6Y4OOVUxOriLqOpIMQw91HFp+zn
	 ++CL3pBSgrjBKBDqCVqYTNJ57LN0NKmAXpkJkRF5eN1Si5SoEM/cVQ4GNXjsRMtndag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=RsfQUXfZ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nUPOyYVc;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0FF606A325
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 22:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B0FF606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=RsfQUXfZ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nUPOyYVc
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 23FAA1400107
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 17:17:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Wed, 18 Nov 2026 17:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795040253;
	 x=1795126653; bh=Sfi+v9RXU9y6hjj5yrpY0/fvAILO6daDnKEy+gfCKSs=; b=
	RsfQUXfZn5SZ1mHkH6R4e7siJwJyo82OOxjWeJyaVI2J3Sa9MrhmCApf9rPnAf16
	kO0BE4OFN4fQEDjJi+U/Bk35CDzZZftKCgpVUwAWew+tXVNd4x72C2CvkkcJIt2z
	07AH0Eu2H+094TseKeaILgUjDJil6JPIuRSZ2aNtVAfWqbGPsT1poj+sTwPRUxos
	4xlNEpdiaZ/vG7NYxbqteoB1rfxfmwUVIhw9l9eSScH440NlZkMTORI7KS48c8Ze
	1my8SThoaxg11paMPAABXQDYXXqfjOXf7Ixt8O5PXeFGf6bNPvw5G2nv7VDkTBXJ
	Ctvn4Kepu1wrdTFOak6Okg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795040253; x=
	1795126653; bh=Sfi+v9RXU9y6hjj5yrpY0/fvAILO6daDnKEy+gfCKSs=; b=n
	UPOyYVcknxYLXNnL9gsHO9zwm8pFBmkQkQB+8TiVJ//YEk2WiI1XRAPGRgLOuEdR
	U6IAXxxSmI3oA7WBxI0Gg5IIbjpxmmMZaNpcgVHEyrjGAcOeN7zj2DmeDqYFsnhr
	Iam8ZpT320YQgxCGaesY5juK/NoV4YuAnHMmHNVKxiGCGUUXrKWk9AthcFUQfdBE
	haoOWE2dDS5g6hBRT/nwDUmws6h/CetPkbOXx8GCAv66rtasedtbcUXOmnw93rFw
	f+ffWJpZ4doWlGykVOy7FMqfzdFf8NZlqk+AVSrbBS0CyyJHwzg6hm1tSfSN0rU6
	ME/08qTWFFQKoyDq65KYA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795040253; d=pobox.com;
	mf=PGJhcnJ5bkBwb2JveC5jb20+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mH25Oh32zbsIZYLDd/AulQpzPfSKTmu0CLBlT0Y+kub/C8v
	yX0lWqkY6G2pddEQpzRELoOUO2TtRFtlMjPcUJZRftiE/Nx3QGFm3U1kLPpikpBC
	cBFXDJQI0IeIM+Mw8VJE8BlKKD/nKlnBXuRh6nwaFWAAVvqfN2FAZuQEyMfJ8XwP
	RTo1qA6QRQczstKZg3bvdRNexRLDFLFOGQ/BHIeLJe2U/fuzozA1wUt0RmBKpbgS
	lGC6BPsT1PpBsUfbwTysEazO2aFwVznQ+X0gn5Zb39Q5p3ILKP5pOCRCmIQZUlt7
	6dB4O/P4yEGK0+9yrySZxVufhBfz5G5gKft3khQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:gR/rDmJw+YOKB6b7OrqmgDyPxWAo1Lk8OBmllnuiyVQ=:J5Dxq7OomZcp6clzJZZRRUjBRMIiVBRAVB3WWrNqg8w=;
X-ME-Sender: <xms:_CP-avGJPsfZHFv1kqC70N6I2mztGXvUSZYrNb3W9SSAx4satfV_0w>
    <xme:_CP-au4hb2Cx9WqlKD-UNFPd0YNBjarHQR5d3jJXIXzVxmBzr1Me7ZS5uMYVl7OVw
    gnV-xdSLZknqFiPhs7IqKgvR3tNfErNVrod5c1p28jcmjfixM3vY9hX>
X-ME-Received: <xmr:_CP-akwbUxow--T41SGuXdh6b_MD8krHl_iyQIJgAy3kAgVVV6VZScuLK2h98CwdJpcssUUCTA9QudjsKGKAGwpGq85d0BuF>
X-ME-Proxy-Cause: dmFkZTGG0+qI7QtTsQ/77oNtjqHNW7sVFNfrQ2AfQuwiFXvDRvHuS4PrzigXTywMy+LSUk
    1wO8IYwuy1TkXAUl9EX7By8FZr/jOciDDP3qZQ20M7VKJKzCbrinGAjHVJbYfZhYcLH1Gp
    Dfshb5Mghe/xIjBUUjwikwOsfCLBS7Y3k3bhYnup60g7VKJDLZtgoR5eK+LPrpRBQMpYdf
    iCEpchpyKRO8SqtBmY5qQ30NXN4pUzX4KzkpZYt5jJlepiF7mAFcW8diaT/uAmZos99SdD
    g+FmznlzcoChwPLehz2zOvUrXtgxMzBRy8/PF7/DHFH7oKZQf/0I5wQGONiWAnRR2OMPBG
    02dIn6urBgtW8HCnrzglUWLVN8cZruRd+DDg2jor7kRuNgvjYiovG5G43h5H/TydNjqjLK
    Wec2FJ31eUEnyFvIpy3JKzQWgSmlJPzret3yqoVahqm4Y78tLi5jNtM6TBRP3f/YfzsxPB
    ijkx/kmpjczjvZoPW2Je9FcN8/HjsYpEhxiaN8b1KP/7xQlFMu8GrOVXvYhBatg8wtFKFX
    gTxPhN3IJlZMg9G6ZxxBasHD2c2G3dmiR6VI81/L3YqgyikdS7jtl6Cy6v+Q1O0YJQO69s
    rX0lAxEN2ZOjIirAFKc9Vej9wGxuJFpblrYRhdNBZrYDz7TJqqhC8bgQwuMg
X-ME-Proxy: <xmx:_CP-atOchf-lhDBbPmnFevp1pCu08DUMOVCD7XKRwiW8ptTvWLs99A>
    <xmx:_CP-aqmHzeRQgd4QbHXVPPHRwkmTfnKTm21J19PDT51siycgyT4-lA>
    <xmx:_CP-aiRP0sJ5YHDqGkAikX4XUpi6ZFOytE4TbPc9QZQcRjKJd-Qmlg>
    <xmx:_CP-apUG3dzZwtFpD86GXXRRZZxffitkmlFmewgjNVsyfUZu8wc_qg>
    <xmx:_SP-auEbZjlH5eEpWSIm7j8qB-lJBVLRtq_q58l_WCwZg6a4bqKP6Rfs>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 17:17:31 -0500 (EST)
Message-ID: <b5b8bc11-35bd-45f9-adac-648c1646ac32@pobox.com>
Date: Wed, 18 Nov 2026 14:17:30 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.3 1870/2651] Bluetooth: L2CAP: take chan->lock for
 l2cap_chan_add/ready/del
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Pauli Virtanen <pav@iki.fi>,
 Eulgyu Kim <eulgyukim@snu.ac.kr>, Jaeyoung Chung <jjy600901@snu.ac.kr>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 Sasha Levin <sashal@kernel.org>
References: <20261118150247.972732815@linuxfoundation.org>
 <20261118150354.286313754@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20261118150354.286313754@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/26 6:51 AM, Greg Kroah-Hartman wrote:
> 7.3-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Pauli Virtanen <pav@iki.fi>
> 
> [ Upstream commit 385c0829e09e7a6380ae67998ac6ef6f4dfd5303 ]
> 
> chan->lock must be held for __l2cap_chan_add as eg. calls to
> l2cap_chan_close assume chan->conn writes are guarded by it.
> 
> It must be held for l2cap_chan_del() due to
> l2cap_sock.c:l2cap_chan_conn, l2cap_monitor_timeout, etc.
> 
> Similarly it should be held for l2cap_ops::ready (assumed in 6lowpan.c).
> Also teardown usually has chan->lock held, it should always have it held
> to have the same locking context.
> 
> The lock is not correctly held by l2cap_core in several places.
> 
> Add the missing locks for l2cap_chan_del/add/ready(), except in
> l2cap_ecred_rsp_defer() which needs separate fix as it needs lock
> nesting.
> 
> Fixes: 6fef032af009 ("Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
> Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   include/net/bluetooth/l2cap.h |  3 ++-
>   net/bluetooth/l2cap_core.c    | 15 +++++++++++++++
>   2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 3d9a32094347c..f64568cb51169 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -971,7 +971,8 @@ int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator);
>   void l2cap_chan_set_defaults(struct l2cap_chan *chan, struct l2cap_chan *pchan);
>   int l2cap_ertm_init(struct l2cap_chan *chan);
>   void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
> -void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
> +void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
> +	__must_hold(&chan->lock);
>   typedef void (*l2cap_chan_func_t)(struct l2cap_chan *chan, void *data);
>   void l2cap_chan_list(struct l2cap_conn *conn, l2cap_chan_func_t func,
>   		     void *data);
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 47f0449588ea1..60720a8cce826 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -703,7 +703,9 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
>   void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
>   {
>   	mutex_lock(&conn->lock);
> +	l2cap_chan_lock(chan);
>   	__l2cap_chan_add(conn, chan);
> +	l2cap_chan_unlock(chan);
>   	mutex_unlock(&conn->lock);
>   }
>   
> @@ -4136,6 +4138,8 @@ static struct l2cap_chan *l2cap_new_connection(struct l2cap_conn *conn,
>   	if (!chan)
>   		return NULL;
>   
> +	l2cap_chan_lock(chan);
> +
>   	l2cap_chan_set_defaults(chan, pchan);
>   	chan->ops = pchan->ops;
>   
> @@ -4144,10 +4148,13 @@ static struct l2cap_chan *l2cap_new_connection(struct l2cap_conn *conn,
>   	if (pchan->ops->new_connection &&
>   	    pchan->ops->new_connection(pchan, chan) < 0) {
>   		l2cap_chan_del(chan, 0);
> +		l2cap_chan_unlock(chan);
>   		l2cap_chan_put(chan);
>   		return NULL;
>   	}
>   
> +	l2cap_chan_unlock(chan);
> +
>   	return chan;
>   }
>   
> @@ -5130,6 +5137,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
>   		goto response_unlock;
>   	}
>   
> +	l2cap_chan_lock(chan);
> +
>   	bacpy(&chan->src, &conn->hcon->src);
>   	bacpy(&chan->dst, &conn->hcon->dst);
>   	chan->src_type = bdaddr_src_type(conn->hcon);
> @@ -5163,6 +5172,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
>   		result = L2CAP_CR_LE_SUCCESS;
>   	}
>   
> +	l2cap_chan_unlock(chan);
> +
>   response_unlock:
>   	l2cap_chan_unlock(pchan);
>   	l2cap_chan_put(pchan);
> @@ -5353,6 +5364,8 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
>   			continue;
>   		}
>   
> +		l2cap_chan_lock(chan);
> +
>   		bacpy(&chan->src, &conn->hcon->src);
>   		bacpy(&chan->dst, &conn->hcon->dst);
>   		chan->src_type = bdaddr_src_type(conn->hcon);
> @@ -5385,6 +5398,8 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
>   		} else {
>   			l2cap_chan_ready(chan);
>   		}
> +
> +		l2cap_chan_unlock(chan);
>   	}
>   
>   unlock:

This is breaking the build for me with clang 23.1.6 (also 23.1.5) for
arm64, amd64 and i386:

net/bluetooth/l2cap_core.c:708:2: error: calling function '__l2cap_chan_add'
       requires holding mutex 'chan->lock' exclusively
       [-Werror,-Wthread-safety-analysis]
   708 |         __l2cap_chan_add(conn, chan);
       |         ^
net/bluetooth/l2cap_core.c:969:1: error: mutex 'chan->lock' is still held at the
       end of function [-Werror,-Wthread-safety-analysis]
   969 | }
       | ^
net/bluetooth/l2cap_core.c:966:14: note: mutex acquired here
   966 |         have_conn = l2cap_chan_lock_conn(chan);
       |                     ^
net/bluetooth/l2cap_core.c:4197:2: error: calling function '__l2cap_chan_add'
       requires holding mutex 'l2cap_chan_create().lock' exclusively
       [-Werror,-Wthread-safety-analysis]
  4197 |         __l2cap_chan_add(conn, chan);
       |         ^
net/bluetooth/l2cap_core.c:7571:2: error: calling function '__l2cap_chan_add'
       requires holding mutex 'chan->lock' exclusively
       [-Werror,-Wthread-safety-analysis]
  7571 |         __l2cap_chan_add(conn, chan);
       |         ^

The following creates a minimal config to reproduce this:
# First set the LLVM environment variable appropriately, then:
make tinyconfig
./scripts/config --enable CONFIG_NET
./scripts/config --enable CONFIG_BT
./scripts/config --enable CONFIG_WARN_CONTEXT_ANALYSIS
./scripts/config --enable CONFIG_WERROR
make olddefconfig

git bisect says:
# first bad commit: [2fab5322c15581b8506e622327e16e005f506308] Bluetooth: L2CAP: take chan->lock for l2cap_chan_add/ready/del

This build failure does not occur on 7.4-rc3, so perhaps there's
a missing dependency.
-- 
-Barry K. Nathan  <barryn@pobox.com>
