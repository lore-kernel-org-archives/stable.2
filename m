Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB43A5304A7
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664470; cv=none; b=KcYWV4IrybLM8gLNxYJ0W4HKIDi3twCkouZqYByvpqOdbC4GIfiJRGFsLb/bD3QCS5FTrtVwESRk+avkUhawEMFB/TQU1iSGU6qneAU2TIkw+T+9yA/OLK5Sdn85Fu5AaFHYplWsAc4LpuglpivEW7zMqbcllD3DE2MFv8Vp72Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664470; c=relaxed/simple;
	bh=B2DIEOfiu6m2jYhcfQxwPgrR40S7t8sjAFAF5ReukeA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=TkQcXCdYJ9qEyDdILSyyREHI9NbNMg0DhiMp/LMU4WmwyAdSV9OnxQBO+Al20hqijvtZaV0twvUMgFZR58gtiFlfb/hDD4n4OVrAK9IOqb38VSS4u8JGgBQ1lmTK/UPRzkwECEqE8RG1XroZNFrc8JioRWbGza+CaeJQ9KiUPW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oP2U1C6v; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oP2U1C6v"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398c066106cso909675a91.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 10:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789664468; x=1790269268; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9r+Nmb9u1of9YV/2d3L5W7crVXgzglxIBbWntwiFrig=;
        b=oP2U1C6v6NEuEi16j4ISIERfcbQXIWC/tguAFAl/1xgyF+3FT/wu/+znaqKJj/iBDa
         ssMEyKWbUgRszefgZ3s5T1TCbePIyN/opF66r6MEpBq+oEbD+Xh/7yn7rtfOHjVtIf3/
         9Ze4VZR4l6LAETtv3bWgq9m/1Xsmr+KeWC8vKpzd2AQl9qbmIRC2Gbb7qnFA4jgoxT23
         +3ThUvp1elhnGCbnVuubwU/GgkUyrIqoBaXTkgAVzP2aNqAQQlf0JjOcY1CkHUKsSp9T
         +DLucLuiJYE1y2E5/vwnXRMKcMzsBG0UuRDNpMVIx44zZC6y+yje7HTw4kiB2N4s/dkQ
         6rgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789664468; x=1790269268;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9r+Nmb9u1of9YV/2d3L5W7crVXgzglxIBbWntwiFrig=;
        b=FwGQ9j9tO+yupE9/F/A8Y5BRm9ABBLl9zRJL4ceUlFcoqobwLol7ZuOUhXh7mIt6Nq
         fAZBrsSTg7hDyySy7NPzsGFc+jvhC8QIeQId8a9ZuB+6S1hcdongFmGEZKvvV+2j3U0b
         LfxndCXt6PBJTn0HZpX6+7SkRzhV/vXMYab7NZNwV6gwfh1PVJSZQwI7947RFC5uee7W
         L48JUrYVckbkf+AUHoiz9rAcjYw5RkQ2owqgJEz7bz3tzI5MUcxyKbtJewSZnzTco5vJ
         52JITtOllz57sVhWqV2rY4aiD3ziPGjlfZ+sDybJe3vwn/fa4/kD6CzJ8Wey4ka5fzbt
         3W+A==
X-Forwarded-Encrypted: i=1; AKwUvByOBMdSE4ktTSWFqNCKG+lGCT+dh9EVnLsk88T4qaJl+CaJnM9ie3gdMbQZeNRWaWlf5F+CXN0=@vger.kernel.org
X-Gm-Message-State: AFuF++lrPFgo53lfV4aO9VwNXQuscw183viHoN377yPgh5d364dHIAtG
	5ivbMkOuPrQmH3/pI4veiAQH7nrVtjba/B4LJp9c/3GMNhbnTN3lgLC6
X-Gm-Gg: AYBFou3PwKpyZiX3Zuha71556RzOl0mDhWBNeQSXohnk+upNELyIYslsh2iL47CduGC
	WMbf5Y78AFI18r8J7VyReHHRWYzpJuBEXfgl9wSDfC4ykpbcgej+C4qQLYl0EQ9O3rSzLHoJUwD
	2hrN5n+NN68Tdcm1UqidLO1wu77JRwrlfV4TKnzNe7NfgpwcavXsl9/I3il3uibmYP1o/GTJ1WW
	0ndrvHIn62jSW2s9og2y8hpmEE2MSEUGcoyKny2Q6DNyQ64ZfD4iZMZAZAoE17yeSN4Je6hzMP0
	Fxu5zoKQsZGqIlj3HTHYIfoAUkEB5BT2wKWywAbRy74wIQdAD4HnOXaAZkzoje/qibOtFvr89Pb
	XEkp/ycENZkffDSXzgmFQLwAhwGasjcjXzoZihncZY5QuapxJJ8q7CI0/b85mxc0o3HATNibeYB
	kZhZAGTcYcfU2udOzecMk7vCwE1N5Dvut7gfiw4zX3P3y6oZbTGizwLeEM3bEHuW0QIJ0w4lzZh
	Ho2ctZkqusGNaErFP99N3PkLSQSfQ7C30gJ8p3pDAuQjLZWxhmshfvHnwlX0gKhu8Mpm7Bx92KZ
	YrNh
X-Received: by 2002:a17:90b:544b:b0:39e:359f:8539 with SMTP id 98e67ed59e1d1-39e359f8573mr16938434a91.15.1789664467801;
        Thu, 17 Sep 2026 10:01:07 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e36170735sm5918501a91.8.2026.09.17.10.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 10:01:07 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 17:01:06 +0000
Message-Id: <DLHR3TXGGQQA.35NANUU0VNBB2@gmail.com>
Cc: <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <davem@davemloft.net>, <kuba@kernel.org>, <hawk@kernel.org>,
 <john.fastabend@gmail.com>, <sdf@fomichev.me>, <xmei5@asu.edu>,
 <stable@vger.kernel.org>, <co+ac0a8c41de69121d@bugs.sh>
Subject: Re: [PATCH bpf] bpf: reject dev-bound-only programs on other
 devices
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bestswngs@gmail.com>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>
In-Reply-To: <20260917161335.1020405-2-bestswngs@gmail.com>
References: <20260917161335.1020405-2-bestswngs@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Sep 18, 2026 at 12:13 AM bestswngs@gmail.com <bestswngs@gmail.com> wrote:
> @@ -698,11 +698,14 @@ static bool __bpf_offload_dev_match(struct bpf_prog *prog,
>  		return false;
>  	if (offload->netdev == netdev)
>  		return true;
> +	if (!bpf_prog_is_offloaded(prog->aux))
> +		return false;
>
>  	ondev1 = bpf_offload_find_netdev(offload->netdev);
>  	ondev2 = bpf_offload_find_netdev(netdev);
>
> -	return ondev1 && ondev2 && ondev1->offdev == ondev2->offdev;
> +	return ondev1 && ondev2 && ondev1->offdev &&
> +	       ondev1->offdev == ondev2->offdev;

With the !bpf_prog_is_offloaded() check above only offloaded progs get
here, and __bpf_prog_dev_bound_init() already rejects those unless
ondev->offdev is set. ondev1->offdev cannot be NULL. Drop this hunk.

Also drop the "attacker" wording from the commit log.
It's CAP_BPF + CAP_NET_ADMIN.

pw-bot: cr
