Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6AB42A140;
	Mon, 27 Jul 2026 23:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195797; cv=none; b=B6HbvXbrd30gP/QYIIYf2aH3PEVm6NIJg+KBVRO0jUZd/rT/jh7R7ovxBqXPPM3TquFmFfBxCTfLqxTVBcbYPsTlfOZCziKg3J6m2b9IggXUxBoxSl/L23XLkcjVSfALLjLD70v4BjzkPGbQX4OzZwmtrrnWVp+02TLlSPed18k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195797; c=relaxed/simple;
	bh=bZehtIqash1U0/Y/AAJLbGBhmxdCjWqmJPhtYFPQuYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXmvbpirSe5Y2Qvaettbt8GCSrlRRStbB+0QBqkWAaRfIsVQg1sqeMkbV3pMgaEVqu/pBOBzYDtMkETJXs8mVeQL4OfcjE7XU0JBBdjbQFwSId0pMJVn2Z0xEXnz4wj/YkR6jUrFoD1dXOndZJlvVh6sZoOq8R6bvsEw/VTUBnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=L/Gp0g7W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sy60ehEd; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="L/Gp0g7W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sy60ehEd"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id EE93E1D00329;
	Mon, 27 Jul 2026 19:43:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 27 Jul 2026 19:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1785195793; x=
	1785282193; bh=wPXlgAALg5wMzufitY8gOnSnrWEJcY0YkJ9hZe3Mcno=; b=L
	/Gp0g7WR+ktkhsUVHx/8CPbe9JMsQvsDq0ZzV61MSE2iRTlCIFcHRwh3E3glzpZq
	bVxmdNFNTVpvYd8rXBvFtf78yVvzAuJ+K6mdGk3ttL7XMYKfxAriZyYLNzUODgnr
	sCAizQteIINNiCbQNjw8YKnXBugV0hFsD0tC+TOE4F83nqKinr/UHj8UXWemX/mS
	oommOlmyK8vyByZ5eHjtzwStKkUYKMrYfvAPaDN4C9ZwHXKE0i/WdceK9S2bWdye
	o+H4GnA2KljhIERUW2Wq9ItC3rdcD3xxEHOFfPL7yfP6CMfBEY05fF2edTerCshk
	ZNgt489jDS9FVmjInjTgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785195793; x=1785282193; bh=wPXlgAALg5wMzufitY8gOnSnrWEJcY0YkJ9
	hZe3Mcno=; b=Sy60ehEdjeNBzYJoiNrfzMtZS/R4PBRSZCN1YD3lGL0aJ8oh1dP
	a0yoc8a0Kfest4yzy4NXBc01AJ6/fPX3TWKh6r87FPaNWeb/jvdaM6244TpWNXl+
	r0qlhFnucAbemi2ToM98w+lfGT5k0rSqPm6FmyIVr4Hl4H7lyxA2fbAy0ld8vUkn
	tXvUIYvjNYTFFoRvIaKcF+T1bj6a8g3bc8F20wythKtUiMFkW937zOV6gLQpRWUz
	V6CxQGVQioacnELN+cKkKtA2NTon6ZcHQSbsEQjeEmybqyR0iWYJY/XsNWl70sBx
	9IZK1Dv/bndso/L3NKT9yViLMjR4vwvTaOg==
X-ME-Sender: <xms:EO1naq3OKxyuY2pguAw74XUFspHaTf4OZf9B_uZZeZiLLJDVntTFkg>
    <xme:EO1naumXc20XX_sVweSZM8nvIB-xKqselrxn_8DmFHV_zTHqi7ueU2cfadTmXqp5X
    kLAoj-uMYOTplVDPmu24gehrVq_vQ3bZ-zCF8yGSn4q3ZCAKASAk2E>
X-ME-Received: <xmr:EO1nai_BlMJyAlKxrdVRX_Z-VZ8Jy54YpYrky75Og1aHQmWXmJ7WcCUHcqGzZNNtV8nKy3kqBq__TTf0jK8TlChCj1jY>
X-ME-Proxy-Cause: dmFkZTE+hNa5URCQPtAcILDH+aonaH/sBTNiGVWhJoKRsesHNs2RSNcTc0Ot9KkGdx2J2q
    TFmux3QFMGOo5s1vpk+4H342fHo7Y/qFSpfi53uRZgpnQEN8bo1rrYwVACX7YYNsvIpSPY
    KMmScUyaZLBs5dGSoOKT9ZfHHwgPGVeL1sFTpJJsqsgAmsAXLUzO9dLH4wKxTrTr991/X4
    2N0gMu++i2wFIQS9AS+cFbvKhpYECmxQl4sSll+8rmbgU/bk4vMMSTzViKX43bryRUM2ws
    An/ryWOB0S8ZaLFdPHqdKK8QDWh0+MbPyygIqkTCpRIX4cMswfVSW2peaZWXpzrrOCSML/
    dZOfBTEi+hPXqvpSGimYLy/ynN7VVm7hTrT8VFApCZHs4d84ww3Z30+uofV9RHCqICyjuj
    KilyRmdpsQEgV+vvI46gr20QARHOe0KQ+GzlAMNERCCnGzB9hkNPNmTqWYCusUvOymaZ/N
    KPdndIywyiMgPY+nmUkdc4LJXC900r67YUHgqOnHRchlzqlwhqtsfHItgTCUaWDHhZf3ll
    FE/YNqq1x3+ptVRnIbPc/gSet5zYbzyj7PouFLOSqMJLDu7fsmBODqQiHWVRmHeOf9GyvI
    KhKPBhx9CQYM3JJbkd0q6BSK64OVbbvIDLtrKAD4adWIfcfHJJPzjsPyKQog
X-ME-Proxy: <xmx:EO1narrUNlyFCF7je0IaVK6KruwFE6VwMG24ywl3wi7rlD50nvbXyA>
    <xmx:EO1najn3KEQBmQwqOnpPsklczkRkw1SJxvfOnQsI30fTlaNBiK8nmQ>
    <xmx:EO1naqi6iyHldXcWk_48lRxnA17sD1Mx9TOaBYJ5UbhTqXJuKy4NtA>
    <xmx:EO1najfE1N233SZG3p65jQ8U48iYn_45xios5XvDTdr1258Idj45zQ>
    <xmx:Ee1nagy9_KBrm2EWL8AeTMqMQcvnAUhnvk4vYvjP9iZnVxRmQToBDLEI>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 19:43:11 -0400 (EDT)
Date: Tue, 28 Jul 2026 08:43:08 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] firewire: core: fix possible memory leak in build_tree()
Message-ID: <20260727234308.GA244925@sakamocchi.jp>
Mail-Followup-To: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <20260727095955.104972-1-nihaal@cse.iitm.ac.in>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727095955.104972-1-nihaal@cse.iitm.ac.in>

Hi,

Thanks for the fix.

On Mon, Jul 27, 2026 at 03:29:53PM +0530, Abdun Nihaal wrote:
> The memory allocated for node in fw_node_create() is not freed when a
> parent port inconsistency error occurs. Fix that by adding a kfree().
> 
> Fixes: 3038e353cfaf ("firewire: Add core firewire stack.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> ---
> Compile tested only. Issue found using static analysis.
> 
>  drivers/firewire/core-topology.c | 1 +
>  1 file changed, 1 insertion(+)
 
Indeed, there is a case to leak the memory object for the node found
newly. However, I have a slight concern that the simple call of kfree()
would cause another issue, perhaps.

> diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
> index df2ac0dab106..317f8f57e521 100644
> --- a/drivers/firewire/core-topology.c
> +++ b/drivers/firewire/core-topology.c
> @@ -227,6 +227,7 @@ static struct fw_node *build_tree(struct fw_card *card, const u32 *sid, int self
>              (enumerator.quadlet_count > 0 && parent_count != 1)) {
>              fw_err(card, "parent port inconsistency for node %d: "
>                     "parent_count=%d\n", phy_id, parent_count);
> +            kfree(node);
>              return NULL;
>          }

When arriving at the line, all of children nodes have the reference to
the issued node.

======== 8< --------
250                 for (i = 0; i < port_count; i++) {
251                         switch (get_port_type(sid, i)) {
252                         case SELFID_PORT_PARENT:
                                    ...
265                                 break;
266 
267                         case SELFID_PORT_CHILD:
                                    ...
273                                 child->ports[child->color] = node;
                                    ...
276                                 break;
277                         }
278                 }
======== 8< --------

I guess it required to invalidate the above references, since the
reference would be used to release the child node.

======== 8< --------
diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index 75a6b0df670a..8bb6aa1b5d54 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -286,6 +286,11 @@ static struct fw_node *build_tree(struct fw_card *card,
                    (next_sid < end && parent_count != 1)) {
                        fw_err(card, "parent port inconsistency for node %d: "
                               "parent_count=%d\n", phy_id, parent_count);
+                       for (i = 0; i < child->port_count; ++i) {
+                               if (child->ports[i] == node)
+                                       child->ports[i] = NULL;
+                       }
+                       kfree(node);
                        return NULL;
                }
======== 8< --------

I'd like you to recheck the above point, since the above perspective comes
from my rough code review.


Thanks

Takashi Sakamoto
