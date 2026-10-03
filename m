Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A0A49B5D7
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791057067; cv=none; b=EKxczNCaw79Ef5xRjiJBpZtuaEe3xscjm5zlpY9JO9XThokvfDaT2KfKQ4N5YesXWr/LqcZ8ETbf+5ecQitDizbTzCrLgmuk6qHqyHWlu7Y2kfza7GUb39U2wRk1MltqrNkezLX1v1EGti04nQabGaRvwcAAhBxZOko3hIxdhCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791057067; c=relaxed/simple;
	bh=7pBfjveomDnmzdvLDU2dmhnc89A87sIYXO91YioPoWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RX/lT+e53dF8O06rIPu4qh8IB7dZRoQ0fkd9Sd6eM4JQGD5W04Nkm6jbF7yeEZZFkXsmd2XA1YqRk36D9bbzYKF0MZ1nxApHAvhTpEEvb0mypb2FTQzQ6hVeoUbl+7P5ENC8AuChtgigOmVMdaHKgYGOyoELrZQ3r7Y+4UXBjK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r7TsFJis; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7TsFJis"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a0977b9c20so10980505e9.2
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 12:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791057064; x=1791661864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GthwDRkP6iGq1qpE9Gwptow6c+M7A3HXNDwh7Y2Glb0=;
        b=r7TsFJisSQnFR036Lx7A3Ji+tzCpGYhe36jSD/1CrNjzKkkUnhOFutTi0oZ8QDVvQA
         SpENr3VGQuDmepT7B+/+FDgtGuckXgd57laUnrWsHoJKpieDiZwRUj8Ls5fJ4aLEcKGW
         YzIUHlHQX1wR4R/TXUA1u7UYoK4QqnnJF6p2lKaoCJSr6wXJDL5GB+Dt3LcN6T/ZMYW7
         s5HCD8nUFNxMb/bWeQsFcuvPLZDIHs0RA1PeeM26EaDI0TRsqaRxZtZoAys9h4AkLfas
         Xr7fw01ohlN/mlEkPd8dRv47KHJy6ek2PwQCZLBLL775D6mYjpZd2vA9/Qh9QPi7KszP
         RhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791057064; x=1791661864;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GthwDRkP6iGq1qpE9Gwptow6c+M7A3HXNDwh7Y2Glb0=;
        b=WSFNBGL6Z9vymLYzcb34muvineMFKPQAZGQULfIgu1d5au7MCkYB9kT+gSa9XoWM2k
         kqolnNu847U+GxAU/NxVPO9JqAw1YV6JRj8xyoYK9WB39fTRNUtvMI631fd/GsdnH5vi
         u6qkBmWUNM6ER5twaGhzHxWpBaGN+GV46kGw3diTcINhCNTquRqtTH9nWwZktJRSvDD7
         2HiBOc3RqfZ/NWwpqs8/FBipjFRMRgYCek1DmLctMBvWCVZWxT8SNFC+MwjLbH79YjwJ
         KT8ExVK1zNoXM6hxEcV6qrwgwTtd7OvjwqSMyA5X2ua6sM4GDul6vtW4raodYceBjtLr
         uKXA==
X-Forwarded-Encrypted: i=1; AKwUvBzIXP3ZBxCGECnDDR68mRRH8Y7MQz3FpVM8faL8ofmyeGjZ8+6PElgeMJnIbizrWFa19SbPi2s=@vger.kernel.org
X-Gm-Message-State: AFuF++l/C8umunaL1RAGh0uCWrwiHpLYi9bWnB1kH3Su+JuGSudb9H0V
	PYG0VNSbbjaaQekwz/oJlHr5tpQBtvLvBY2yT7uvo561VgZobgiqukmO
X-Gm-Gg: AYBFou0F2k77UUfqL0eiQ462PY0gJKdykH02AXdfy1T1SLgx3gG5C7vbt8pSBA4AxvO
	LwAYlPMcRGrrU0/WNUDnMZSRcgWBrtalgHmVCLpV3y338KgfWMWcoxNC94N0EkV/MW/lWzEd2MF
	9m4F1od4ersWL7iRq9lIygkeXuZSwTAGRAMiMOz7JMnrdYaZXHCUSJOy3/66QMZwlrgV5fsGHEV
	kfeSPThlQNyJ6ZFB5tDmNYIykU4Elg6wNkGltDwuAiaL6rRVimiPNQyWozLxXIxzFNbqs9+843n
	2KWZSy06dDeL2AUhk7+hMlOvLljE8fWgI6WgrDCbuSjBErZD2f93pd9h+ed97D95YGAgfIllYzn
	V9525w5pLQkVJYjcYwNBmFbW5/i7ShmJnjlSuhHFsO9cJEh0AvOwvSzGpoX1BCOzt6doEWFC2Kr
	Y3alrcc82SmF4P5zfhn8mcD+sSIsZf8VpSGrF1s3tZMzDIjmagw5SErXCmni+tXEVVoCt+LR+0J
	jQ63+xx5fA15XP1pZHgfThiHakC5fkvuztCAg==
X-Received: by 2002:a7b:cd8e:0:b0:49f:bd3c:bc18 with SMTP id 5b1f17b1804b1-4a02758ff89mr75811725e9.19.1791057063698;
        Sat, 03 Oct 2026 12:51:03 -0700 (PDT)
Received: from [192.168.20.170] (5403F394.catv.pool.telekom.hu. [84.3.243.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280b2e3csm233621055e9.5.2026.10.03.12.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 12:51:03 -0700 (PDT)
Message-ID: <4ae83db6-768d-447e-b177-3ef5206267f9@gmail.com>
Date: Sat, 3 Oct 2026 21:50:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gcc-ipq5018: mark 'gpll0_main' clock as
 critical
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc: Stanislaw Pal <kuncy7@gmail.com>, Mieczyslaw Nalewaj <namiltd@yahoo.com>,
 Jie Luo <jie.luo@oss.qualcomm.com>, Georg Seema <georgseema@gmail.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260918-ipq5018-mark-gpll0_main-critical-v1-1-fbe8f27a0106@gmail.com>
 <e16cf23c-82aa-465b-81b2-6240f4a0f4d9@oss.qualcomm.com>
 <f2ccd6b6-e5a2-4d36-a12c-124638c31280@gmail.com>
 <66d48e1f-7bab-42f3-84db-ce794f2a2a89@oss.qualcomm.com>
Content-Language: hu
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <66d48e1f-7bab-42f3-84db-ce794f2a2a89@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2026. 10. 01. 18:15 keltezéssel, Konrad Dybcio írta:
> On 9/24/26 1:33 PM, Gabor Juhos wrote:
>> Hi Konrad,
>>
>> 2026. 09. 23. 15:32 keltezéssel, Konrad Dybcio írta:
>>> On 9/18/26 11:27 AM, Gabor Juhos wrote:
>>>> On IPQ5018, the APCS core clock feeds the CPUs. It can use
>>>> different clocks as its parent, but during system boot it
>>>> utilizes GPLL0.
> 
> [...]
> 
>>> At a glance, we have the CPUs consuming
>>> &apcs_glb APCS_ALIAS0_CORE_CLK
>>>
>>> which takes XO/GPLL0/A53PLL as parents.
>>>
>>> GPLL0 is a child of GPLL0_MAIN, so this should never be gated in
>>> practice. devlink and probe deferrals should make sure you always
>>> get a valid clock handle for the cpufreq driver..
>>
>> Yes, the cpufreq driver gets a valid clock handle. However the hang happens
>> early, when the 'apcs_alias0_core' clock is not registered yet. So CCF does not
>> know that the clock (hence the CPU) is a consumer of GPLL0.
> 
> So is that the late_initcall kicking in early, disabling unused
> clocks,

No, disabling unused clocks happens much later.

> or is there some other logic that ends up disabling the
> GPLL?

In the actual case, it is being disabled by runtime PM, which happens due to the
pm_runtime_put() call in the 'ipq_cmn_pll' driver's probe function.

Adding a WARN() into the clk_alpha_pll_disable() function results in this message:

  WARNING: disabling 'gpll0_main', expect a system hang!!!
  WARNING: at clk_alpha_pll_disable+0xd8/0x108, CPU#0: kworker/u8:0/11
  Modules linked in:
  CPU: 0 UID: 0 PID: 11 Comm: kworker/u8:0 Not tainted 7.3.0-rc1 #0 PREEMPT
  Hardware name: TP-Link Archer AX55 v1 (DT)
  Workqueue: pm pm_runtime_work
  ...
  Call trace:
   clk_alpha_pll_disable+0xd8/0x108 (P)
   clk_core_disable+0xec/0x278                 # gpll0_main
   clk_core_disable+0x110/0x278                # gpll0
   clk_core_disable+0x110/0x278                # pcnoc_bfdcd_clk_src
   clk_core_disable+0x110/0x278                # pcnoc_clk_src
   clk_core_disable+0x110/0x278                # gcc_cmn_blk_ahb_clk
   clk_disable+0x38/0x60
   pm_clk_suspend+0x120/0x170
   pm_generic_runtime_suspend+0x34/0x58
   __rpm_callback+0x50/0x200
   rpm_callback+0x60/0x78
   rpm_suspend+0xf4/0x5e8
   pm_runtime_work+0xd4/0xe0
   process_one_work+0x258/0x860
   worker_thread+0x1c8/0x378
   kthread+0x140/0x158
   ret_from_fork+0x10/0x20

However the problem is not specific to the ipq_cmn_pll driver. It is a race
between probing different devices.

For example, consider a simplified probe function of a driver:

  static int ipq5018_gpll0_consumer_probe(struct platform_device *pdev)
  {
          struct clk *clk;

          clk = devm_clk_get_enabled(&pdev->dev, "foo");
          if (IS_ERR(clk))
                  return PTR_ERR(clk);

          return some_function();
  }

Then assume the followings:
  - "foo" is a descendant clock of GPLL0
  - the probe function runs before probing other devices, so the probed device
    will be the first consumer of GPLL0
  - some_function() returns with an error code

The result will be the same hang. Due to the probe failure, devres disables the
clock, but since the the device is the only consumer of GPLL0, it is getting
disabled as well.

Here is the repective WARN result:

  WARNING: disabling 'gpll0_main', expect a system hang!!!
  WARNING: at clk_alpha_pll_disable+0xd8/0xf8, CPU#1: swapper/0/1
  Modules linked in:
  CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.3.0-rc1 #0 PREEMPT
  Hardware name: TP-Link Archer AX55 v1 (DT)
  ..
  Call trace:
   clk_alpha_pll_disable+0xd8/0xf8 (P)
   clk_core_disable+0xdc/0x268
   clk_disable+0x38/0x60
   clk_disable_unprepare+0x18/0x38
   devm_clk_release+0x2c/0x50
   dr_node_release+0x24/0x38
   release_nodes+0x78/0x118
   devres_release_all+0x84/0xf0
   device_unbind_cleanup+0x34/0x98
   really_probe+0x190/0x3f0
   __driver_probe_device+0x174/0x1e0
   driver_probe_device+0xc4/0x130
   __driver_attach+0x108/0x258
   bus_for_each_dev+0x6c/0xb8
   driver_attach+0x2c/0x40
   bus_add_driver+0x128/0x258
   driver_register+0x68/0x138
   __platform_driver_register+0x30/0x48
   ipq5018_gpll0_consumer_driver_init+0x2c/0x40
   do_one_initcall+0x6c/0x548
   kernel_init_freeable+0x264/0x388
   kernel_init+0x34/0x1f0
   ret_from_fork+0x10/0x20

Maybe this helps to understand the problem.

Regards,
Gabor
