Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.83
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795075989;
	b=s4aqQ/c8aZG7vSh0J6f2ZSbpY5xJouxjsxx698e/C++jlMigfO+7hj2RYiuJ/8m20kfo
	 Xn+reLE3ISs35DwZ3K2OOuFk1w7a/qOXvGl9oUwv4gzPxHF00SaxVQuHhFLluXFjDrH9/
	 9BOYvdNXYLYRcMRyprEDZx9UOyyhxVe7wHC7WpiVDN2S2f7je5ah8LFRNsojwlnXnoZ7W
	 vinLQYSOi5hTqYuPxFUATuZcCanICucexgl1gn0MuZfFPZvrfiMQGQzopUC+8N1n/I2jU
	 gFJV0aO459TdRvzih+vYV+GGrQFlUNcvjg8Mc6MwwJmlC3VpiollPXJ2toqN26oIUGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795075989;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=/a4blFPKZLEYxSlyx62bUldvxxADK2mtDNcfDLcAils=;
	b=2Yq7eM5gKB5v3o53Qe75dPE6lJJuKIYNqnHsPV7jeRYf1EkeyaJ/4C7t7vNg26+sWOcM
	 QBaoE/Zy3ilU2xIbkQjVPJo8f3pWc+DgPnWXbBQUSUzZ6MQpqjXShs+bYObJia9xskhJR
	 fH3Rq1KOjPP7yfq5xpyMDYFf/ijfls0Ev8zHnxEc7s4TeJLtNXRTnSy1HMRHlHqRAB0ZK
	 YAg1ErU5Ugft8JewUnMGUF6GInVOQs336iYu3x48sxis60EOPlmebYU45XmyLuOWoYjjN
	 4N0XeOKCHzwGmE1ibpF9V9TifBgk0Hq0PwUqRukwss0PhEykWkmZuRytdHCZ3KdwyBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=oHc5nIR3;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="bcJqy/5X";
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.83
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A866606A320;
	Thu, 19 Nov 2026 08:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A866606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=oHc5nIR3;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=bcJqy/5X
ARC-Seal: i=1; a=rsa-sha256; t=1795075980; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JTZqV4aWK9hh4Ro8daSeITliXFkUT81PMK7UtdcbER5in/H+oX1ghFcDjNjv+JeINc
    W3OdDm9SdmJrHs0BNlls8+tuSkUy86IpA+ImjzoK3q46ZBM/p0dSolh1sbbP1rqz3j7z
    XObd2Pyyu9YsA4+APEHJK975Uqmu/QSkyNbdgPeDAZcgI1E7SBfXmyZSNV3Rrzc3F+WX
    LAKscJBFg8Ug2FGqzAl/f+tbuL3MvxXYIvJmzMzm7PFH+Wkg/08wCsfkVGpAnWtcjeX/
    5i9mDuHTcounD2xAMPQCwPhD1VWPFCIixr+9LwAiy3iZ8xOlsGQ7Jn6+4H8w8W8byaVi
    l08g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795075980;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=/a4blFPKZLEYxSlyx62bUldvxxADK2mtDNcfDLcAils=;
    b=KnMsIcDYF55krFnmd83p5nmWPBAnXDSIJk/Md0jtItbehuardoRMADg420p1vMyuIZ
    68IbLzkX8oT4YNkTrI2uD0/Y5n6hXNUa3DzC8h4mVE4VdqtznqQDfH634BCUrpetus2Q
    TRSV/0mSqKm0+MhTwE7fdEpw6o3YIsObGmq8T79OOTICgGcmnKM+AGS43VmhS6JezGVb
    H8y+zyZMR/rRWyOB4DL92wXL+wAZyDJTsz+JjO3SxLHgCACHTopP/OvMtyjEXySf8Ruy
    8mzs6iKoil0wjU0Rr3udX2yPQvLetJBafA1V49WQK2g/l1Oa1af5RuIq57XEyT8eLSSS
    +rww==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795075980;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=/a4blFPKZLEYxSlyx62bUldvxxADK2mtDNcfDLcAils=;
    b=oHc5nIR3JWl0KwwLiTFwvsQ8SIxID/DDz5kGSIKxjwCQOABC/eKh6Xe80QTKo3EIvJ
    Zs8F40uu1TlysDLRXUAfnEwMG/d+1/FmUg6wMdRqskC/FxtbdnZpEZ8S0kXopWld6tjK
    I6BpOG0jGLTiBn76zGTI66st4lWDXTySxN882DTtcfokNurCfQs0U17an0eOW+sDF9cd
    mDVqG/8kMLGkxTH3S7OpYLNav7MInwqGwZ5TRfBCh5WEQoE5xR44RTWvlBwbQcHS8tOy
    W4yYTgDk9bmsnvJppR5f48Xj4sA9m03h0+M0zg3SKNYQ1emNbWMH1UOMNiN0IrhJyN4V
    YJcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795075980;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=/a4blFPKZLEYxSlyx62bUldvxxADK2mtDNcfDLcAils=;
    b=bcJqy/5XsDOUQDdIrvEI7mPntBwDaYYdIcdktROStmI19pglAzzB+dXr2rOht8M+6W
    +Eibsy7vtDxOxqhUkBDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AJ8D0Jxk
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 19 Nov 2026 09:13:00 +0100 (CET)
Message-ID: <0d784fe7-a527-46a4-9e45-37b35ce512ce@hartkopp.net>
Date: Thu, 19 Nov 2026 09:13:00 +0100
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
Subject: Re: [PATCH net 08/11] can: netlink: fix static FD-NON-ISO mode
 validation
To: netdev-bot+sashiko@kernel.org, mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, zhuling0805@qq.com,
 stable@vger.kernel.org, mailhol@kernel.org, o.rempel@pengutronix.de
References: <20261117220818.1142581-9-mkl@pengutronix.de>
 <179504036152.3136.12444797036692057668@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179504036152.3136.12444797036692057668@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18.11.26 23:19, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The patch fixes a second, older bug but tags only the newer one.
> 
> --
> 
> can: netlink: fix static FD-NON-ISO mode validation
> 
> This patch moves the "fd is disabled" exception for the static FD-NON-ISO
> mode in can_ctrlmode_changelink() from ctrlstatic to ctrlstatic_missing.
> That stops requests such as 'fd off' or 'loopback on' from being rejected
> on controllers with a static FD-NON-ISO mode. It also adds a check that
> rejects any request which explicitly switches off a static control mode.
> 
> Link:https://lore.kernel.org/all/ 
> tencent_3A964832542399A780E646D6A6246335C409@qq.com/
> Link:https://netdev-ai.bots.linux.dev/sashiko/#/ 
> patchset/20261115095746.709371-1-mkl%40pengutronix.de
> Link:https://patch.msgid.link/20261117-can-bcmlock-memcg- 
> v6-8-6826a6227d36@hartkopp.net
> 
>> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
>> index 081dfddda0008..521e2496e2cc3 100644
>> --- a/drivers/net/can/dev/netlink.c
>> +++ b/drivers/net/can/dev/netlink.c
>> @@ -330,9 +330,17 @@ static int can_ctrlmode_changelink(struct net_device *dev,
>>   		return -EOPNOTSUPP;
>>   	}
>>   
>> +	/* static control modes can not be switched off */
>> +	if (deactivated & ctrlstatic) {
>> +		NL_SET_ERR_MSG_FMT(extack,
>> +				   "static control mode %s can not be switched off",
>> +				   can_get_ctrlmode_str(deactivated & ctrlstatic));
>> +		return -EOPNOTSUPP;
>> +	}
> [Severity: Low]
> Should this patch also carry a Fixes: tag for commit c9e1d8ed304c ("can:
> dev: replace can_priv::ctrlmode_static by can_get_static_ctrlmode()")?
> 
> The commit message says this check closes a bug that existed before
> 6742ca18cb41:
> 
>    "before the above mentioned commit a request like 'fd-non-iso off'
>    passed the check and removed the static CAN_CTRLMODE_FD_NON_ISO bit
>    from priv->ctrlmode. As can_get_static_ctrlmode() derives the static
>    modes from priv->ctrlmode, this information was lost permanently."
> 
> The permanent loss comes from can_get_static_ctrlmode() in
> include/linux/can/dev.h, which was added by c9e1d8ed304c (v5.17):
> 
>      return priv->ctrlmode & ~priv->ctrlmode_supported;
> 
> Before c9e1d8ed304c, priv->ctrlmode_static was a separate field, so this
> path could not clear it.
> 
> In trees that have c9e1d8ed304c but not 6742ca18cb41, take M_CAN v3.0.x or
> v3.1.x, or pcan_usb_fd with firmware < 2.x. A request with
> mask=FD_NON_ISO, flags=0 and FD not switched on passes the check. Then
> 'priv->ctrlmode &= ~cm->mask' clears the static bit. A later 'fd on' is
> accepted and reported as ISO mode, while the hardware stays non-ISO.
> 
> The only tag is:
> 
>      Fixes: 6742ca18cb41 ("can: netlink: add userland error messages")
> 
> With only that tag, will the stable tooling skip this fix for LTS trees
> such as 6.1, 6.6 and 6.12? Those trees also lack ctrlstatic_missing, so
> the patch would not apply there as is.
> 
> Would a second Fixes: c9e1d8ed304c tag help here? Or a note that older
> trees need a separate backport?

No. Trees with c9e1d8ed304c but without 6742ca18cb41 can still lose the
static FD-NON-ISO bit, but only after an explicit (and pointless)
'fd-non-iso off' while FD is not enabled. The common configurations
('fd on fd-non-iso on' and 'fd off') have always worked correctly there,
and 'fd on' without 'fd-non-iso on' is rejected as intended.

Even in the corner case the hardware keeps running in non-ISO mode:
M_CAN v3.0.x/v3.1.x has no NISO bit (non-ISO is fixed in the IP), and
pcan_usb_fd with firmware < 2.x never gets an ISO mode command. Only
the reported ctrlmode would be wrong until the driver is reloaded.

So this is the only Fixes: tag needed. The regression that rejects
valid configurations was introduced by 6742ca18cb41, and the stable
backport follows that tag.

Best regards,
Oliver


> 
>>   	/* do not check for static fd-non-iso if 'fd' is disabled */
>>   	if (!(maskedflags & CAN_CTRLMODE_FD))
>> -		ctrlstatic &= ~CAN_CTRLMODE_FD_NON_ISO;
>> +		ctrlstatic_missing &= ~CAN_CTRLMODE_FD_NON_ISO;
> [ ... ]
> 
> -- Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/ 
> patchset/20261117220818.1142581-2-mkl%40pengutronix.de
> 

