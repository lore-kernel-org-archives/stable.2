Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8791937756C;
	Mon,  5 Oct 2026 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791188178; cv=none; b=nzlblqFjQIiuQxAYLVRogtag7S7+HF9zho2JJLrNyCCd/UNGmoqKYyqvP4tCy4BfxLv6j0/FA/KB2GqsnN+2lwEooKzyg3Nb7OgyMKc6er04HZqIxgiRHZBn63hvOclqxTctAk5vz9Ja+RSFljI40jEByxbcmRLWA/3ac5+AA5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791188178; c=relaxed/simple;
	bh=TVSyeZxNsNvZ6vTozahYX1bCfmz5Uzn+fmIaVVDd4EU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GI2nMrMl8TGcxceXx8TWFUaBvsqmV01ZDeUFH/XeZeMZAetOZ/+wZx7++buCKH1zFicqRpxujwx2rgOJZ/XVup6Kw7C5dQHGPeNEwUKLEQ14ZO4UWnLwi1IiFlkLsSSLfk1ZMI8WPQm/3KLudxjX/MdrGq1sb0utYvD40qEXG+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=Nn64ln6s; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="Nn64ln6s"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=pkLuxiXt3VuVVpbJXJpFSrkPv4x9rYEArG3Rcs/r7rk=; b=Nn64ln6sQzgXN09CFM9t9VZc/r
	zUdlbqNcpjgwZbra/7CLPQTf4S9uWhSwrGkYRiSkH/vf9O5Sn//HVJoJeI8ce+SLIZfoZe7iLWsv0
	GRh0JWGnUUTC1sFlBH+HysEEVxfF/WI1Ga1Sr8cccxzXB6UEKHQ+glqApSIcR/sqN7PG9xWjKm1qt
	xOnJHU9wrDUSNVcKt1ZOeoH29VxviBY4maUQBy7RkiHXpAYeMch+2hLpFsXUk8dqRL3bGex/GoJka
	QIGALVU+WBw+lvXNpt32kvDZgVNTcr5786g70VgKYKAlH109dtndW/MAeTKnLnoDa8N7CPX1snfbB
	d0uOMu9w==;
Received: from [::1] (port=55282 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xDdrq-000000026bW-2pOJ;
	Mon, 05 Oct 2026 10:16:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 05 Oct 2026 10:16:14 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: subash.a.kasiviswanathan@oss.qualcomm.com
Cc: 'Sean Tranchetti' <sean.tranchetti@oss.qualcomm.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: qualcomm: rmnet: require real-netns admin for
 bridging
In-Reply-To: <000a01dd548c$ea3417a0$be9c46e0$@oss.qualcomm.com>
References: <20261004203149.3042491-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <000a01dd548c$ea3417a0$be9c46e0$@oss.qualcomm.com>
User-Agent: Roundcube Webmail/1.6.19
Message-ID: <3350a4902b5da1e5315206d26513019b@oss.cyber.gouv.fr>
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

On 2026-10-05 07:46, subash.a.kasiviswanathan@oss.qualcomm.com wrote:
>> -----Original Message-----
>> From: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>> Sent: Sunday, October 4, 2026 2:32 PM
>> To: Subash Abhinov Kasiviswanathan
>> <subash.a.kasiviswanathan@oss.qualcomm.com>; Sean Tranchetti
>> <sean.tranchetti@oss.qualcomm.com>
>> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Jérémy Jean
>> <Jeremy.Jean@oss.cyber.gouv.fr>; stable@vger.kernel.org
>> Subject: [PATCH net v2] net: qualcomm: rmnet: require real-netns admin 
>> for
>> bridging
>> 
>> An rmnet device keeps its link to the real device when moved to 
>> another
>> network namespace. The bridge callbacks change the real port, but 
>> rtnetlink
>> only checks CAP_NET_ADMIN in the slave device's namespace.
>> 
>> Require CAP_NET_ADMIN in the real device's namespace before adding or
>> removing a bridge. Use the slave device's namespace for the 
>> comparison, since
>> that is the namespace rtnetlink authorized.
>> 
>> Fixes: 60d58f971c10 ("net: qualcomm: rmnet: Implement bridge mode")
>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM
>> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>> ---
>> 
>> Changes in v2, after Subash Abhinov's review:
>> - Add the teardown check and use slave_dev for both capability checks.
>> 
>> v1: https://lore.kernel.org/all/20260821202845.4053530-2-
>> Jeremy.Jean@oss.cyber.gouv.fr/
>> 
>>  .../ethernet/qualcomm/rmnet/rmnet_config.c    | 20
>> ++++++++++++++++++-
>>  1 file changed, 19 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
>> b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
>> index bed6f63facf2..62d7acb13e0c 100644
>> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
>> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
>> @@ -441,6 +441,13 @@ int rmnet_add_bridge(struct net_device
>> *rmnet_dev,
>>  	struct rmnet_port *port, *slave_port;
>>  	int err;
>> 
>> +	/* The rtnl path only checks CAP_NET_ADMIN against
>> dev_net(slave_dev),
>> +	 * but bridge mode below controls real_dev, which may live in 
>> another
>> +	 * netns.
>> +	 */
>> +	if (!rtnl_dev_link_net_capable(slave_dev, dev_net(real_dev)))
>> +		return -EPERM;
>> +
>>  	port = rmnet_get_port_rtnl(real_dev);
>> 
>>  	/* If there is more than one rmnet dev attached, its probably being
>> @@ -489,7 +496,18 @@ int rmnet_add_bridge(struct net_device
>> *rmnet_dev,  int rmnet_del_bridge(struct net_device *rmnet_dev,
>>  		     struct net_device *slave_dev)
>>  {
>> -	struct rmnet_port *port = rmnet_get_port_rtnl(slave_dev);
>> +	struct rmnet_priv *priv = netdev_priv(rmnet_dev);
>> +	struct net_device *real_dev = priv->real_dev;
>> +	struct rmnet_port *port;
>> +
>> +	/* The rtnl path only checks CAP_NET_ADMIN against
>> dev_net(slave_dev),
>> +	 * but bridge teardown also updates real_dev, which may live in
>> another
>> +	 * netns.
>> +	 */
>> +	if (!rtnl_dev_link_net_capable(slave_dev, dev_net(real_dev)))
>> +		return -EPERM;
>> +
>> +	port = rmnet_get_port_rtnl(slave_dev);
>> 
>>  	rmnet_unregister_bridge(port);
>> 
> 
> A similar patch was committed recently in net-next. Please refer to 
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=26ee8cd69d46a14b37ba5e512084fe80d730127a

Thanks for the pointer.
I was too slow processing your feedbacks, but good that it is patched.

Regards,
Jérémy
