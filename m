Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794052247;
	b=hh9ZBF3oAQMl2TuDo+Ls5gPCfwOxrW+WaBb6C0YPq9KdCtt/5RBKO5vjU86JH2N8e2+m
	 cxlOHHr80fgjqdoGYDsvYqpxJ40MFEIkPqqU+tvqesCLElVkkqtZWHqe39k5DfFMqSm+F
	 +/M6QS7QXgmB1tynjgYbVNVyBHTJIbf2SXefUrPglhrDBRYXeuayd4z/NZ3rRDKSk1D62
	 vOfAC2Mbgyi1jtwcX4fe+hbURuDuWwGM2CYR+Gq9BVDNPR+pUn9QglGOZEQur87eVfqTq
	 SfF2CvFzYxYX+/y7H9xqD87DjhUdxjNydQ71Bf+C57Lt0wjny71II28JYUSV34p47ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794052247;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0nl3EtW/t9ZcBzb8A/tKhYaRHR6Wov+cG3wp3yyG6Fw=;
	b=SDb8aUQIhrNkzXro978XkEH8BEp+jcgRM2CHU1Vp1w6MLXtSikU9mE+ajL84IasauYEI
	 SKZT3zRHBk6prPFDRRFUp5+k69UecG8cH2S1CmC7q2Hy8uQbTnAiAWe6U7ESdpGMWx7JC
	 VG1+EqSVBgXBGVe719dQNQCmw9YSLXtPRlU4/5nCRo3spDYsN9ipjpdwK+KhkqF7h3BoG
	 8XFZjcR/il8eie5zzSw1zaA/xh+re7fr+NyE7Y0eeEc9IE194QF9s5UudJFDVoi7wyN5m
	 RNj63t+4NiT47R4vlwA83+mhxzgelXO27tySCf168Q2u4QtNm0hsRZOJuQiic3hmdeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4yDtueU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A550606A326;
	Sat,  7 Nov 2026 11:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4yDtueU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667A31F0089F;
	Sat,  7 Nov 2026 11:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794052247;
	bh=0nl3EtW/t9ZcBzb8A/tKhYaRHR6Wov+cG3wp3yyG6Fw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=i4yDtueUQSU5XJr9MzitR2Fl+pi/ipaP5eQHiW3wI8jA04yP3Ok9og7wETsVtL5Dd
	 khsI5tCNk0CRHKKOlG5BgT5h7oGlEJDKOSwH17Ic4gXhNV7wJ1tJ+XPYWd1vXME0Cd
	 uzIBb2RH4riODr+k1Urj2IwkxxLY9aRKfBeaQ9ZexG0draPrkjTVvs8fAsmMtclti5
	 MrH+i/d+Tby9UEB8FLJUiqWL3QuAmGyRYvVHo/MiylZGgxcF/pV+cOIXf7OKY58OHM
	 T34Wir8JbVG2jllyGg71m2PV3nBpyM4ntVqk4Z4X2Oa933BCwnXuFsz44lwfMgooyv
	 ynUWz5evMo9zA==
Subject: Re: [PATCH] ice: release the VF reference in the switchdev trust path
From: netdev-bot+sashiko@kernel.org
To: vulab@iscas.ac.cn
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sat, 07 Nov 2026 11:50:45 +0000
Message-ID: <179405224597.994134.14854399116658341017@kernel.org>
In-Reply-To: <20261103100530.1309907-1-vulab@iscas.ac.cn>
References: <20261103100530.1309907-1-vulab@iscas.ac.cn>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The Fixes: tag in commit "ice: release the VF reference in the
  switchdev trust path" points at the wrong commit.

--

ice: release the VF reference in the switchdev trust path

In ice_set_vf_trust(), the VF reference taken by ice_get_vf_by_id() was
not dropped when the request was rejected because the PF is in switchdev
mode. This patch sends that path through the existing out_put_vf label
so ice_put_vf() is called.

> ice: release the VF reference in the switchdev trust path
>
> ice_set_vf_trust() takes a reference on the VF with ice_get_vf_by_id()
> and then rejects the request when the PF is in switchdev mode without
> dropping that reference.
>
> Return through the existing out_put_vf label so the VF reference is
> released on this path too.
>
> Fixes: 1281b7459657 ("ice: Forbid trusted VFs in switchdev mode")

[Severity: Medium]
Is this the right commit for the Fixes: tag?

When 1281b7459657 added the switchdev check, it was at the very top of
ice_set_vf_trust(), before any VF lookup. VF refcounting (3d5985a185e6)
did not exist yet, so the bare return did not leak anything.

The leak seems to come from 83b49e7f63da ("ice: check if VF exists before
mode check"). That commit moved the lookup above the switchdev check and
did not change the early return:

    +	vf = ice_get_vf_by_id(pf, vf_id);
    +	if (!vf)
    +		return -EINVAL;
    +
     	if (ice_is_eswitch_mode_switchdev(pf)) {
     		dev_info(ice_pf_to_dev(pf), "Trusted VF is forbidden in switchdev mode\n");
     		return -EOPNOTSUPP;
     	}

    -	vf = ice_get_vf_by_id(pf, vf_id);
    -	if (!vf)
    -		return -EINVAL;
    -

With Cc: stable, the current tag would aim at trees that have
1281b7459657 but not 83b49e7f63da. Those trees do not have the leak.
There, ice_get_vf_by_id() still comes after the switchdev check, so a
fuzzed backport would add a goto out_put_vf that runs before vf is
assigned.

Should this be the following instead?

    Fixes: 83b49e7f63da ("ice: check if VF exists before mode check")

The phrase "takes a reference on the VF with ice_get_vf_by_id() and then
rejects the request" also reads as if the check has always leaked. That
has only been true since 83b49e7f63da.

> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index c49f48b5ae38c..90bf1becbc3da 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -1400,7 +1400,8 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
>
>  	if (ice_is_eswitch_mode_switchdev(pf)) {
>  		dev_info(ice_pf_to_dev(pf), "Trusted VF is forbidden in switchdev mode\n");
> -		return -EOPNOTSUPP;
> +		ret = -EOPNOTSUPP;
> +		goto out_put_vf;
>  	}
>
>  	ret = ice_check_vf_ready_for_cfg(vf);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103100530.1309907-1-vulab%40iscas.ac.cn
