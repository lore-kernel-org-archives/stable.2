Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EB43BBFDB;
	Tue,  6 Oct 2026 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276682; cv=none; b=WHxqQqGcvuSHt8FHKtfIQ2b0XU/JW1gcGPdEZ+B3sKhkhDwxmgpV8QgOy9wzCeKEkMrX70iil0gUYgz1dDiRizHN8Q7q1ZGsgMeX/JDRp5i5TSDi/72GPkVVs4CTJVB/EzvnW4omaugeEtxu9OSrq1GLMH4wqD3Dp+3THD8WmaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276682; c=relaxed/simple;
	bh=lfHs3WMCyfBI72XKxfzOT8l5Sfu6YM4Cjdl36t7iCLA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=lMTctArOU84PpoWCK2/xZGOgdh1VlwGSv277DO71tEtClzi8PDIKmMRoNrfFtwQFnnNTM72WV4TOh0mKiqF0WasMRickDEQHve+sbYTuJ9ekl+nyocqejQSB2BLpGItJDKxLN0hLzNOFWZZGPNIl4BnSr5hyipTr/mTcKrLKrbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=BAyq03/t; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="BAyq03/t"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=9LrG8ftmhdRLs4AbrToBr7oo7Wnt+ieCpJ8s6nQlpDA=; b=BAyq03/tM7eIA+nyNuvWkrNsU5
	+ETEVL5WY2y8uQpI3w2Wh9u5p/lbXZ3Xr8FoqO7gSRutHgcbINzKY4VWvn0r2xmg39h0fzHV3YYtE
	G4BklvJJM0YSl+0a/K7YY/ektSTp/SPgj8nMqcebCDn2vgJDHs1uTcL3KW1oIOgx7ZumMIgT/SsrH
	epmJhKcC7ZbeyRv81ujA08zFaCOEfrTI0bkEti1TdkjINMjQF3RNRaeUDxGWDf9dYiV/zlh7zCBo9
	YuWxhGft5FUD1MGFXwAEl0HgvDibC/6S84hQHZGvi1sBs++xtoMwJi79/YcqxWd4KBd5LWRkvXsSD
	OwM9NJtQ==;
Received: from [::1] (port=45174 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xE0tJ-0000000AvYP-37Sx;
	Tue, 06 Oct 2026 10:51:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 06 Oct 2026 10:51:13 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
 Sabrina Dubroca <sd@queasysnail.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Boris
 Pismenny <borisp@nvidia.com>, netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH ipsec 5/7] net/mlx5e: Use the packet sequence number for
 the IPsec IV
In-Reply-To: <76e305ba-47c0-4028-afdf-294dcfea11de@nvidia.com>
References: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20260930144523.435271-7-Jeremy.Jean@oss.cyber.gouv.fr>
 <f50caced-1810-4f33-99bf-cc69a0851c08@nvidia.com>
 <af8f1e51975cb74188f645a8fd20a6cd@oss.cyber.gouv.fr>
 <e65b8b035eadcb1a776278b0887a57d7@oss.cyber.gouv.fr>
 <76e305ba-47c0-4028-afdf-294dcfea11de@nvidia.com>
User-Agent: Roundcube Webmail/1.6.19
Message-ID: <0148c4045a29e1fa2f1760ff858961ef@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-10-06 08:49, Tariq Toukan wrote:
> On 05/10/2026 21:28, Jérémy Jean wrote:
>> On 2026-10-05 15:50, Jérémy Jean wrote:
>>> Hello Tariq,
>>> 
>>> On 2026-10-05 15:06, Tariq Toukan wrote:
>>>> On 30/09/2026 17:45, Jérémy Jean wrote:
>>>>> mlx5e_ipsec_set_iv_esn() may decrement xo->seq.hi for a GSO skb 
>>>>> based
>>>>> on the SA's current output counter. The metadata already contains 
>>>>> the
>>>>> high word for the first packet, so this can produce the wrong IV.
>>>>> 
>>>>> For a three-segment GSO skb starting at (H, 0), oseq is 2 and
>>>>> oseq - gso_segs wraps to 0xffffffff. The helper then uses (H-1, 0)
>>>>> for the IV instead of (H, 0). This can create a situation where GCM
>>>>> reuses a nonce.
>>>>> 
>>>>> Remove the high-word adjustment and use xo->seq directly to 
>>>>> generate
>>>>> the IV.
>>>>> 
>>>>> Fixes: cb01008390bb ("net/mlx5: IPSec, Add support for ESN")
>>>>> Cc: stable@vger.kernel.org
>>>>> Assisted-by: LLM
>>>>> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>>>>> ---
>>>>>   .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c         | 12 
>>>>> +-----------
>>>>>   1 file changed, 1 insertion(+), 11 deletions(-)
>>>>> 
>>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ 
>>>>> ipsec_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ 
>>>>> ipsec_rxtx.c
>>>>> index 6056106edcc6..4aa9f9c52f57 100644
>>>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
>>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
>>>>> @@ -153,21 +153,11 @@ static void mlx5e_ipsec_set_swp(struct 
>>>>> sk_buff *skb,
>>>>>   void mlx5e_ipsec_set_iv_esn(struct sk_buff *skb, struct 
>>>>> xfrm_state *x,
>>>>>                   struct xfrm_offload *xo)
>>>>>   {
>>>>> -    struct xfrm_replay_state_esn *replay_esn = x->replay_esn;
>>>>> -    __u32 oseq = replay_esn->oseq;
>>>>>       int iv_offset;
>>>>>       __be64 seqno;
>>>>> -    u32 seq_hi;
>>>>> -
>>>>> -    if (unlikely(skb_is_gso(skb) && oseq < 
>>>>> MLX5E_IPSEC_ESN_SCOPE_MID &&
>>>>> -             MLX5E_IPSEC_ESN_SCOPE_MID < (oseq - skb_shinfo(skb)- 
>>>>> >gso_segs))) {
>>>>> -        seq_hi = xo->seq.hi - 1;
>>>>> -    } else {
>>>>> -        seq_hi = xo->seq.hi;
>>>>> -    }
>>>>>         /* Place the SN in the IV field */
>>>>> -    seqno = cpu_to_be64(xo->seq.low + ((u64)seq_hi << 32));
>>>>> +    seqno = cpu_to_be64(xo->seq.low + ((u64)xo->seq.hi << 32));
>>>>>       iv_offset = skb_transport_offset(skb) + sizeof(struct 
>>>>> ip_esp_hdr);
>>>>>       skb_store_bits(skb, iv_offset, &seqno, 8);
>>>>>   }
>>>> 
>>>> Thanks for your patch.
>>>> 
>>>> Doesn't this make mlx5e_ipsec_set_iv_esn() identical to 
>>>> mlx5e_ipsec_set_iv()?
>>>> 
>>>> I wouldn't keep both copies then..
>>> 
>>> Good point: after a quick check, indeed you are probably right.
>>> I will look to simplify this in a new version of the patch series.
>>> 
>>> Jérémy
>> 
>> It seems to me that a delete only patch would be okay then? (see
>> patch below).
>> The removal of the check in mlx5e_ipsec_set_esn_ops() makes
>> mlx5e_ipsec_set_iv() the only callable function. Then it seems
>> one can simply remove lines. Do you confirm?
>> 
>> 
> 
> From a quick look, it seems we can do even more by totally removing the 
> set_iv_op function pointer.

Indeed, thanks for the suggestion.
Below is a diff to do this.
Does that you look right to you?

  .../mellanox/mlx5/core/en_accel/ipsec.c       | 18 -----------
  .../mellanox/mlx5/core/en_accel/ipsec.h       |  2 --
  .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c  | 31 +++----------------
  .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h  |  4 ---
  4 files changed, 4 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c 
b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index db260e3..de2e740 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -651,22 +651,6 @@ static void mlx5e_ipsec_modify_state(struct 
work_struct *_work)
  	mlx5_accel_esp_modify_xfrm(sa_entry, attrs);
  }

-static void mlx5e_ipsec_set_esn_ops(struct mlx5e_ipsec_sa_entry 
*sa_entry)
-{
-	struct xfrm_state *x = sa_entry->x;
-
-	if (x->xso.type != XFRM_DEV_OFFLOAD_CRYPTO ||
-	    x->xso.dir != XFRM_DEV_OFFLOAD_OUT)
-		return;
-
-	if (x->props.flags & XFRM_STATE_ESN) {
-		sa_entry->set_iv_op = mlx5e_ipsec_set_iv_esn;
-		return;
-	}
-
-	sa_entry->set_iv_op = mlx5e_ipsec_set_iv;
-}
-
  static void mlx5e_ipsec_handle_netdev_event(struct work_struct *_work)
  {
  	struct mlx5e_ipsec_work *work =
@@ -859,8 +843,6 @@ static int mlx5e_xfrm_add_state(struct net_device 
*dev,
  	if (err)
  		goto err_add_rule;

-	mlx5e_ipsec_set_esn_ops(sa_entry);
-
  	if (sa_entry->dwork)
  		queue_delayed_work(ipsec->wq, &sa_entry->dwork->dwork,
  				   MLX5_IPSEC_RESCHED);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h 
b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index abcbd38..172fce9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -278,8 +278,6 @@ struct mlx5e_ipsec_sa_entry {
  	struct net_device *dev;
  	struct mlx5e_ipsec *ipsec;
  	struct mlx5_accel_esp_xfrm_attrs attrs;
-	void (*set_iv_op)(struct sk_buff *skb, struct xfrm_state *x,
-			  struct xfrm_offload *xo);
  	u32 ipsec_obj_id;
  	u32 enc_key_id;
  	struct mlx5e_ipsec_rule ipsec_rule;
diff --git 
a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c 
b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
index 6056106..4a9c334 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
@@ -150,30 +150,7 @@ static void mlx5e_ipsec_set_swp(struct sk_buff 
*skb,

  }

-void mlx5e_ipsec_set_iv_esn(struct sk_buff *skb, struct xfrm_state *x,
-			    struct xfrm_offload *xo)
-{
-	struct xfrm_replay_state_esn *replay_esn = x->replay_esn;
-	__u32 oseq = replay_esn->oseq;
-	int iv_offset;
-	__be64 seqno;
-	u32 seq_hi;
-
-	if (unlikely(skb_is_gso(skb) && oseq < MLX5E_IPSEC_ESN_SCOPE_MID &&
-		     MLX5E_IPSEC_ESN_SCOPE_MID < (oseq - skb_shinfo(skb)->gso_segs))) 
{
-		seq_hi = xo->seq.hi - 1;
-	} else {
-		seq_hi = xo->seq.hi;
-	}
-
-	/* Place the SN in the IV field */
-	seqno = cpu_to_be64(xo->seq.low + ((u64)seq_hi << 32));
-	iv_offset = skb_transport_offset(skb) + sizeof(struct ip_esp_hdr);
-	skb_store_bits(skb, iv_offset, &seqno, 8);
-}
-
-void mlx5e_ipsec_set_iv(struct sk_buff *skb, struct xfrm_state *x,
-			struct xfrm_offload *xo)
+static void mlx5e_ipsec_set_iv(struct sk_buff *skb, struct xfrm_offload 
*xo)
  {
  	int iv_offset;
  	__be64 seqno;
@@ -264,7 +241,6 @@ bool mlx5e_ipsec_handle_tx_skb(struct net_device 
*netdev,
  {
  	struct mlx5e_priv *priv = netdev_priv(netdev);
  	struct xfrm_offload *xo = xfrm_offload(skb);
-	struct mlx5e_ipsec_sa_entry *sa_entry;
  	struct xfrm_state *x;
  	struct sec_path *sp;

@@ -293,8 +269,9 @@ bool mlx5e_ipsec_handle_tx_skb(struct net_device 
*netdev,
  			goto drop;
  		}

-	sa_entry = (struct mlx5e_ipsec_sa_entry *)x->xso.offload_handle;
-	sa_entry->set_iv_op(skb, x, xo);
+	if (x->xso.type == XFRM_DEV_OFFLOAD_CRYPTO &&
+	    x->xso.dir == XFRM_DEV_OFFLOAD_OUT)
+		mlx5e_ipsec_set_iv(skb, xo);
  	mlx5e_ipsec_set_state(priv, skb, x, xo, ipsec_st);

  	return true;
diff --git 
a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h 
b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
index 45b0d19..9a7e032 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
@@ -53,10 +53,6 @@ struct mlx5e_accel_tx_ipsec_state {

  #ifdef CONFIG_MLX5_EN_IPSEC

-void mlx5e_ipsec_set_iv_esn(struct sk_buff *skb, struct xfrm_state *x,
-			    struct xfrm_offload *xo);
-void mlx5e_ipsec_set_iv(struct sk_buff *skb, struct xfrm_state *x,
-			struct xfrm_offload *xo);
  bool mlx5e_ipsec_handle_tx_skb(struct net_device *netdev,
  			       struct sk_buff *skb,
  			       struct mlx5e_accel_tx_ipsec_state *ipsec_st);
