Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC5E48BD47
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285136; cv=none; b=TlQSRdi7tsuBoKdSI+2fdZyViauvqHaXwNvDKZ9QlUMlFcVMx5YjtH6L0Nsqm7ufXjyOUhQjfJTBunEjcRG0BcEqs6Yg876CuLuW2ZjyTZDWey5MWjf86nb4u892DZbtiHZW2PrjEgaglquTGreIA/fDdGpHnOy8wEkd686TECE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285136; c=relaxed/simple;
	bh=5Ljoy05eM2hvOQIEt/wowa0X9gdsi6+0oEQN07gEYGc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=TY/EYgfXNU1FcKt78uROg0VvNIg0Mw2fMc0yd8ArtgY/pOAICWSNqRssmW1qszZ/9FNF03MG/cN+db5f241u5kP5xKIFpQpnTGr+8EsNHhfBmmFKRD58Xt9b4eWgTfEjvrcqdkAsE5o/fbFEHzllm45PH89FfGuwGjK67UCFqAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SpFRfMy4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GyAf6l0R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SpFRfMy4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GyAf6l0R"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681Hg0Yp3302441
	for <stable@vger.kernel.org>; Tue, 1 Sep 2026 17:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cGSjmkq62N7lfw1591YZQUCHweLAEMoRxMNz1OD8vjY=; b=SpFRfMy4AZW6zBae
	H5G8wTgDGfQCN0Kjn7+fOrBxF3d7RNIxQqrABEBiIlZERvV0UUTUCtDTDIH8H5TW
	8eR1nQK4jN3lj7bqHHi4uWh1O1n1tuijdyTtq+Ht7MlxZ6Zik+aNS5mQAz2+HbRg
	ACHZgk8RuPk8Rlg1qjGyG2C4oxyjHoJuv3vctogfEkVqhWWGg3CEpJ3GV4BtwtWT
	YrKf9FMHmVV0CUEtW25NXtOsF9A3PB2+3wNVwZ2zN1EPMGnRHhMmVJd7rPlmpZYD
	2JEaZFUYvtkQsYuOK7zzjAxqQ1upOv2T3rJZ7S6LEOVTYlJ37j542f+atvgxxjiu
	RKF3eA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge37j02eg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 01 Sep 2026 17:52:13 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d55d8cd938so1040915ad.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 10:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788285133; x=1788889933; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cGSjmkq62N7lfw1591YZQUCHweLAEMoRxMNz1OD8vjY=;
        b=GyAf6l0RiblIGLStJmH7k7px8YbaG8sJ9Nn3Bc+bwyrF43WW9BnBRaLvxtyPNjopwG
         x4yd3ePEaWoGa77QTe2UKjQdwHboxQkf9IzdQqFvUnuiWMhDJlRRa/HSpgciBGuIdtwP
         E9Y+C3+oyPvttLe3WJb5gl6fGtGYnCNCoeXz5c2bm2Fp3jeDbAzi817ljNhyl85/QLQ4
         nodLnK1kpiYfNkjriaLKBdIlWnn8J0mw4DbMbW/XZxqrGvXRj2WP9xYgkGsBeuB8xQNM
         PTOWiNj2MybaCvdW75zAAu289rR301eiPzPO2ETaA80idcqSuuRxB0uuN93HZULAyMAV
         cPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788285133; x=1788889933;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cGSjmkq62N7lfw1591YZQUCHweLAEMoRxMNz1OD8vjY=;
        b=lgUBo8ZCUExfMj4gzlFSxZ4/QNKyjiPaiV2jUjTnt15jmTdK/J7axzjYgglFnHdYER
         Vi7YR3p74tLf+Y1ESPLW7s7WDuUUetRjKkvRjGqy/xR50vMw19arkEQZmIDJO0uW4PQI
         TIf1Ok1P8eaHfh6hbItr/jKf0Elzqq69J5+zPJucwNkNUL/oC6vn+LNQp9qx19ZmoCGe
         13S395pEz4Ly9JpH6YZo42FTEQ9OwKT6CPaX/TUvtDi+lhQUNSZ7Hqw2s4gvzNaN4RGU
         zsQxcqPov2JXR2KKxXdsDHjJjEWBOdVAsfUhN7P9oLu5oZNNDuhsvPh1Evd6R6HNM6J6
         I+Vw==
X-Forwarded-Encrypted: i=1; AKwUvBxUTS36np4VvR/0lufqhY9jh1cD7VB7fK/OvWJ2FUYkYUKYVDxdUk+xvjbx9syRC6Z4lIpsl/g=@vger.kernel.org
X-Gm-Message-State: AFuF++m+SVOeNgQC/ONBSdyrlF4aZot0GSbLlOJEnvEIB/UdibAOBQ7l
	bQYc3Xbr2EUKTMTzsJVEUrL3gn7Hvax/3N9P54r6Lq8Yo1Dxs25p0MXfm50OvhOQorO+klWiCj3
	TTI3hF6y5Wv2nh5VyLw/D9I88qXtFauL2nbWqSSZo3nrkyZudwsV3dXkApnY=
X-Gm-Gg: AYBFou1Yay6DxlPr9rVA2Hj5i+qp2r1nbBSmT8vI+c6gd3EMY3nUV5Gtrr5TA7eGQOI
	2ajQwPy572mZ8SXzVzr6Z3Fs87+nM/Eg1SRBHB9PwHI+FYjrpfkui6eWkVLN7CMGl+vKHR+lNVd
	7WRNlY9Us8pkRCtzU5vh3sGLGfxUWN2qiRCHRjv+yS2iI4xpVf8C7DkEF5zmYvEPK+YwECpm8XG
	R3nalQyZajUlkgt9uOBWEMRrRyHcc4ZyyAX0LV5YSOehlkIIyoH0i7sGlJkTWmSas3z864vSUyl
	oZU9e1Bya3caMc8rweXEYa7UpCCs3NCD0nxg6UOIGmGz7u9JbD4/AhpUC5e5FeiUe/k1Rl7Sa3A
	tyrujIlc8jmAtoq0v5pB6DJSfJOfDjcNWqDvrEXgFm/zger7xqUjX544W0IKN9os4C0T7vhqizl
	EXgRUUVYkW
X-Received: by 2002:a17:903:458f:b0:2d6:e074:9cad with SMTP id d9443c01a7336-2dae5e17e23mr202905ad.6.1788285133091;
        Tue, 01 Sep 2026 10:52:13 -0700 (PDT)
X-Received: by 2002:a17:903:458f:b0:2d6:e074:9cad with SMTP id d9443c01a7336-2dae5e17e23mr202475ad.6.1788285132633;
        Tue, 01 Sep 2026 10:52:12 -0700 (PDT)
Received: from QCOMk1gASIiYhG (66-33-8-210.colorado.intrepidfiber.us. [66.33.8.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f784857sm38886128eec.3.2026.09.01.10.52.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2026 10:52:09 -0700 (PDT)
From: <subash.a.kasiviswanathan@oss.qualcomm.com>
To: "'Abdifatah Suruur'" <suruurism@gmail.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sean.tranchetti@oss.qualcomm.com>, <horms@kernel.org>,
        <stable@vger.kernel.org>
References: <20260901081441.632-1-suruurism@gmail.com>
In-Reply-To: <20260901081441.632-1-suruurism@gmail.com>
Subject: RE: [PATCH net v4] net: qualcomm: rmnet: require CAP_NET_ADMIN in the real device netns for config ops
Date: Tue, 1 Sep 2026 11:52:07 -0600
Message-ID: <001701dd3a3a$9c0f8580$d42e9080$@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGwzwKGUDaVs3KPTjfRVyDxc6JAIbcS1wVg
Content-Language: en-us
X-Proofpoint-GUID: lDId9wdf-QCmeHBQ_rNqxcpkFk_ENehI
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1OCBTYWx0ZWRfX1KJamCwWWnUN
 bfi9oKNr+wsM07ClkOuBfNKVD4Wreci5XvcIkoNUOckVDxN2kDGQ5ISEsyFEl/zyrb5cxlxXhcu
 VFW8XtJJ24QrF1uivk9Fej/61Of34wA=
X-Proofpoint-ORIG-GUID: lDId9wdf-QCmeHBQ_rNqxcpkFk_ENehI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1OCBTYWx0ZWRfX2JHdWSI5O/35
 rAFd+KRQqcr8hL+XyPO1QxrjzKl3Ei0Bf1Varstd4KU9hNY9zQM+0U0+FD7Cnqp7PHsq+ZWSuY9
 Q3ycQ7iB3X52E1s9CtjjDiPBJ0IsWiN2JFHNZknREyAq0frvkkfiWQGbiWOWVOSOSHiDBMMeMes
 KvJGltxPkf23v5UnZXO1rBSxSkU6T625HJHCyhW6xW8FEWYm0K93Xg3aHbSkKYhH5KDrCIVvql2
 dyLArT0zu5WA4AxPlOOFE1PkjYOrxAdjGwzZMU89CxUMWSp5nposSjQavIGQR8rY9sFRWvgHuFQ
 14N9tmYsFSALTjivYy5L+5bajY0dQVTz5jhxK7W0yJ7biDGzjKijqouoK4lsGdz3kiePyF87iVp
 MZWEHlDk58OGJ/F0By4HK+maKFIy0lR16EJC0WT3WiesZ/OdB88odRz/ii4nwXQ1NC2wEj6OAQX
 tOScxFnZCUUMzucHoxA==
X-Authority-Analysis: v=2.4 cv=PKg/P/qC c=1 sm=1 tr=0 ts=6a9710cd cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=OltkOWFNRHEXGe+8VJKHzA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=cXkr8SbK9_hmXVLBwXUA:9
 a=CjuIK1q_8ugA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010158

> -----Original Message-----
> From: Abdifatah Suruur <suruurism@gmail.com>
> Sent: Tuesday, September 1, 2026 2:15 AM
> To: subash.a.kasiviswanathan@oss.qualcomm.com
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> sean.tranchetti@oss.qualcomm.com; horms@kernel.org; Abdifatah Suruur
> <suruurism@gmail.com>; stable@vger.kernel.org
> Subject: [PATCH net v4] net: qualcomm: rmnet: require CAP_NET_ADMIN in
> the real device netns for config ops
> 
> An rmnet device may be created with its real device in a different netns
than
> the rmnet device itself (rmnet_newlink() resolves it in link_net), and the
rtnl
> config paths below only check CAP_NET_ADMIN against dev_net(dev), while
> mutating rmnet port state attached to the real device:
> 
> - rmnet_changelink() rewrites the endpoint mux table and
>   port->data_format and, via rmnet_vnd_update_dev_mtu(), can shrink the
>   MTU of the rmnet endpoint netdevs.
> - rmnet_add_bridge() and rmnet_del_bridge(), reachable via
>   ndo_add_slave/ndo_del_slave through RTM_SETLINK IFLA_MASTER, flip
>   port->rmnet_mode and port->bridge_ep on the real device's port; with
>   bridge_ep pointing at a caller-owned device, rmnet_rx_handler() then
>   forwards real-device ingress frames to it.
> 
> A caller privileged only in the rmnet device's netns can therefore rewrite
the
> shared cellular data-path state owned by another netns, and steer its
ingress
> traffic.
> 
> Gate all three with rtnl_dev_link_net_capable(), matching the "require
> CAP_NET_ADMIN in the device netns for changelink" series (vxlan/geneve,
> CVE-2026-68432).
> 
> Fixes: 2abb5792387e ("net: qualcomm: rmnet: Allow configuration updates
> to existing devices")
> Fixes: 60d58f971c1077 ("net: qualcomm: rmnet: Implement bridge mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
> ---
> v4:
> - use the netdev comment style, per Subash Abhinav Kasiviswanathan
> v3:
> - cover rmnet_add_bridge() and rmnet_del_bridge() with the same gate;
>   they mutate the same real-device port state via ndo_add_slave/
>   ndo_del_slave and have no capability check of their own
> - correct the impact wording: rmnet_vnd_update_dev_mtu() only reads
>   real_dev->mtu; the MTU store lands on the rmnet endpoint netdevs via
>   rmnet_vnd_change_mtu(), not on the real device
> v2:
> - drop Reported-by: (implied for the author), per Jakub Kicinski
> ---
>  .../ethernet/qualcomm/rmnet/rmnet_config.c    | 27
> ++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> index 78d4df55740a1..73bd5419cb136 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> @@ -312,6 +312,13 @@ static int rmnet_changelink(struct net_device *dev,
> struct nlattr *tb[],
>  	if (!rmnet_is_real_dev_registered(real_dev))
>  		return -ENODEV;
> 
> +	/* The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
> +	 * but the port state mutated below is attached to real_dev, which
> +	 * may live in a different netns.
> +	 */
> +	if (!rtnl_dev_link_net_capable(dev, dev_net(real_dev)))
> +		return -EPERM;
> +
>  	port = rmnet_get_port_rtnl(real_dev);
> 
>  	if (data[IFLA_RMNET_MUX_ID]) {
> @@ -440,6 +447,13 @@ int rmnet_add_bridge(struct net_device
> *rmnet_dev,
>  	struct rmnet_port *port, *slave_port;
>  	int err;
> 
> +	/* The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
> +	 * but the port state mutated below is attached to real_dev, which
> +	 * may live in a different netns.
> +	 */
> +	if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev)))
> +		return -EPERM;
> +
>  	port = rmnet_get_port_rtnl(real_dev);
> 
>  	/* If there is more than one rmnet dev attached, its probably being
> @@ -488,7 +502,18 @@ int rmnet_add_bridge(struct net_device
> *rmnet_dev,  int rmnet_del_bridge(struct net_device *rmnet_dev,
>  		     struct net_device *slave_dev)
>  {
> -	struct rmnet_port *port = rmnet_get_port_rtnl(slave_dev);
> +	struct rmnet_priv *priv = netdev_priv(rmnet_dev);
> +	struct net_device *real_dev = priv->real_dev;
> +	struct rmnet_port *port;
> +
> +	/* The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
> +	 * but rmnet_unregister_bridge() below clears the bridge state of
> +	 * the real device's port, which may live in a different netns.
> +	 */
> +	if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev)))
> +		return -EPERM;
> +
> +	port = rmnet_get_port_rtnl(slave_dev);
> 
>  	rmnet_unregister_bridge(port);
> 
> --
> 2.53.0

Reviewed-by: Subash Abhinov Kasiviswanathan
<subash.a.kasiviswanathan@oss.qualcomm.com>

