Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4560F429CDC
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786452890; cv=none; b=MQmhn7BcBR50zex2cBMrcHKtIAqUG8/YUDjCgoqFrSfeuyAvitfhjSDcDXOz+8xqvpPx8axBDDxxh6oVBcxuLTGXWsEBWjVwEQKbb3IXuD5dDoPeLjtx6Jd7BExx2VIASH3atN4j3BR1fnS+1LTPM9LsmDdcXO7pNdGaMF2yWcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786452890; c=relaxed/simple;
	bh=WrGtbioOi/SDFuRuNSxOxOV6312aFHRM48aXVi4YmF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O1Qp5wGuNlbxPz/EN1dwhDTovPhtHtUOmOHaGx/QqzfYr1KqUiMIzvCkw40xWjFc6GxNye2hA/f2uD9sJArs6gR4M2dd55jl1sVh7wTEAkjPr2G2CtDp55Q3zIRKf0iJjORr/lipLWnN4k4UybzwEgTf6temTx+Wo+JacjSvj+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X4SXIOo6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dn1yd/27; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X4SXIOo6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dn1yd/27"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BCRChQ306877
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q2flNnNINmCRt7k82OXXAcPlTbp6zvDLw77zk2/CNIA=; b=X4SXIOo62TvEmWjZ
	4VtxsL6b5UZqW/pZxZP3sTkge7WMUMg82U4FUS+0WCkw0YMDrhbxDz2xaX6L8R2n
	JzFK2OQTMvw1rFnDLLvP7D31Xljc3AJFzTYs+vlFrJRXjBf6Y1SUeBQt5TlTXYsH
	6O52WqoHOCJ4v9lgMj4zrKBfTBWdL7J9kzBf9G50P5uxlRojfHrLYBnHvsj0Abj7
	S6uqNOR9Mvnk34dp73264nHW6Y6kKwtSe88BiOg7n9h9YjSHOUTWARq8NXD9UO7j
	Tkyyqcg+VAwXIKH/acpUAlSO7AnQMzXwIWyNReH2QWW55714ec92MtPfnmDYZ9CK
	ANHu6Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjsm6kk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:54:47 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so4736649a91.3
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 05:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786452887; x=1787057687; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q2flNnNINmCRt7k82OXXAcPlTbp6zvDLw77zk2/CNIA=;
        b=Dn1yd/27hdA9Sgd+qaNrQlXCSkGfhOG6aHxVyYRSHiK2ZfVLPSJ1WbZRvhVTWu61oh
         ZnqpeQVi40GkugFIWw6mFOKAxTdask+W7ReUJTrQ+T2eaBaQS2XDQgXJYbH0wapK03js
         SJXm9MibYOCtvO7m46QIBF3mHngBpavnoaKb+i4u8vloqgGWOObRdIdDZbNS1niOFyhZ
         4m58ccK57zGZkWiBXpfP51Sg1KEEus6fOUUtbPk6RtnQXafjPGgjYtDgEMOp1xcB0u5f
         1xcP598yEx9QAF9Zl6NRFQuaKTGskFS4nLTM0TF9B7xWlUKYjI3m0ee4P15Q4CY2sH4e
         +3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786452887; x=1787057687;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q2flNnNINmCRt7k82OXXAcPlTbp6zvDLw77zk2/CNIA=;
        b=JBYaFKrJkjmjB9W37B9TKNsqoiLQMR/R+oLc8WZSaIWER3SYy167cTQiiRSWLlu6PX
         lfo6rwzh+YN7gEkw3EqDQDL3ltfhHPsKm2Vm9KYclu90w3A/4THCypkFVf0Blt+uGWfX
         JOmDplcEheQuPYRhMwOg5tiu92tqJ/n5Su8t1TYd0uf92DxYoB0Cb2v+kKObIT6M6mmc
         4VSbnUW9DoyJb2P9rHO16sqVTyEPFkoNgzxx+W1bc3RjZgPGQJdXS3moKWyXkwd7MWsB
         xvDvY5h//axT45yDLDRokUH0pqoHJ7dltrZKqWWfHNbJ4japxjo4uLBPCPcvYfXDo4gi
         3thQ==
X-Forwarded-Encrypted: i=1; AHgh+RqozHW98C5UfJLDwxd7/It4I/er1PeFdjGUojLWgS/rQOQ80+uzOwLXZjXMejEipiE519rL2C8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaspGzBkYz8KK5+jbeYIsZ7FiWT4oAhODpzmg2jgnmB6NVFun5
	JKaVjrB90GxDe7/XQH0RXbE4IL3o+0NofPB0JgYnxk7cv5nE/lX1gsqyJW1BTi40+8eVNOBeB1I
	HOAt2YWRs6pyX7Jd60bH63L6XBk7Kw1ZQmMga3Bumr/GicI8C3poHxz0ntd0=
X-Gm-Gg: AR+sD13GspNknN/M3ZTowwlAWdIhBZgX1e+Lc5vb2zUN7djHByKbrnCsbTdTa8J/rwa
	eZDkPp9cGqKGuSNx4aqRk165Vkxyj5GkvdaAxYDAiYIyJp0cyuXdNrVinLzAZQWKN4klnnMFswd
	CwUiGD8D6JVcXm/rib1685yhyaDXznhPgVczwDH+eFFxBQOpKWPC6GaH+WWqJQX4vUUu70hMNst
	TVMM5dEEQZHHXQhHnPhqEM32Mb0EA7mxbuSkCwLz+pAOIR5tAX3IhKRetagRFOjRfPV2x6FXn5z
	spBZ/5otdXFy56w4vxKnYn6fUv5p57uyQe9rd0B7FFoyXMCvTiFPzKneOT02PL7xsAg7/kRz/vF
	6pdFQsxqkXzkP/uwNKaKhGjHMNcq5Czs3zKDdMMnZXGDfQTKcWTRFsTqA72eR4k+V
X-Received: by 2002:a17:90b:2692:b0:38f:1dc:672f with SMTP id 98e67ed59e1d1-392ec6a78c8mr3427677a91.18.1786452886530;
        Tue, 11 Aug 2026 05:54:46 -0700 (PDT)
X-Received: by 2002:a17:90b:2692:b0:38f:1dc:672f with SMTP id 98e67ed59e1d1-392ec6a78c8mr3427620a91.18.1786452886012;
        Tue, 11 Aug 2026 05:54:46 -0700 (PDT)
Received: from [10.133.33.35] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d534abfasm3860675a91.11.2026.08.11.05.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 05:54:45 -0700 (PDT)
Message-ID: <8248f034-d5a6-4f9c-b6e6-77eeb8ca3ad4@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 20:54:41 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: ipq-cmn-pll: keep the CMN block bus clocks
 enabled
To: Stanislaw Pal <kuncy7@gmail.com>, Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Brian Masney <bmasney@redhat.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <fdc4410c-18f3-4f34-8519-deb37862477c@yahoo.com>
 <20260809161012.378743-1-kuncy7@gmail.com>
Content-Language: en-US
From: Jie Luo <jie.luo@oss.qualcomm.com>
In-Reply-To: <20260809161012.378743-1-kuncy7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEwNyBTYWx0ZWRfX0SHWtHTirU/u
 PW3PdTS3iA4fCP6F/xUzN2G1Yzspc4i2oiGoIB3kPfhMzar6hvEgNRqFUKWlAWVRuoC+WozAQWx
 DQD2BHSFCsvw7+GVsqFZa2hd2kOXf4E=
X-Proofpoint-GUID: BobsYt0Q6k0t3TOklJ7meY0At_5VJeMm
X-Proofpoint-ORIG-GUID: BobsYt0Q6k0t3TOklJ7meY0At_5VJeMm
X-Authority-Analysis: v=2.4 cv=cfDiaHDM c=1 sm=1 tr=0 ts=6a7b1b97 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=Ki7mIbe9vPJvlQghS2sA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEwNyBTYWx0ZWRfX08p7cD2Awb3g
 M6OYVCDVmeTzQpz+HVTKceeCWfvMrNNiUgcrv1/YY5yW952um9mszDc7NRk95FIX6uGK8uBGRAl
 5vrEZBuz2A0jZ/5wY37/FRKD+p/6MIXZa9DDrp9whIqoIUPklGPT3RWjWgnSX87irDsK1lNd6s7
 Ua+Xif3VG0dsoFfvmefl+qiJ+yW4GGkrhlUmlZ564dvc+vQ9PpY/ewwJAhSQtyGnR98hue4XYtn
 WzgIG3WV2cuw9aazlz0Z9ogq53bR6aMfmcbowOBb3zY4JsMVWT+044cOzru5vWgRIZeoxQE2r7G
 0hbc0l9HZFA9/UmOZDS/SqPjtVSX+Ys4/WxsJPTx2OrHCauOvWmZ7WcnKZU/XSIsfyD8bLR67oZ
 6mJ4zxCfUxnbarZskGrghCOw9Yaqv0ZMp7qLLxdP/yW4BrYLTZnmzYNVrVMJhm4LjTqYjSVUxYd
 2E0wfm+VqZ5vxzWGKYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110107



On 8/10/2026 12:10 AM, Stanislaw Pal wrote:
> On 8/8/2026 Mieczyslaw Nalewaj wrote:
>> Given the hang is reportedly 100% reproducible pre-userspace, is there
>> a concrete next step to root-cause it, or is v3 the right call for now
>> with a follow-up tracked separately?
> 
> There is a concrete step, and I ran it today on a third board - this
> time with no code of mine involved at all.
> 
> Hardware: GL.iNet GL-B3000 (IPQ5018), a supported in-tree OpenWrt
> board, running the current bone-stock OpenWrt snapshot (kernel
> 6.18.41, which does not carry this patch). Out of the box it boot
> loops: the last line on earlycon is at ~0.39s (the final initcall
> before the driver probes start), then silence and a watchdog reset,
> 100% reproducible.
> 
> Adding exactly one thing to the kernel command line - no rebuild, no
> patch:
> 
>     initcall_blacklist=ipq_cmn_pll_clk_driver_init
> 
> makes the same image boot: serial, SPI-NAND, SMEM partitions,
> remoteproc all come up.
> 
> Combined with what we already know from the other two boards, this
> isolates the trigger fairly tightly:
> 
>   - cmn-pll probe runs, last PM reference dropped (vanilla): dies
>   - cmn-pll probe never runs (blacklist, clocks stay as the
>     bootloader left them, i.e. enabled): boots
>   - cmn-pll probe runs, reference held: boots - verified on this same
>     board today with an image carrying v3 of this patch and nothing
>     else changed; it comes up fully (shell over SSH, NAND, remoteproc),
>     and clk_summary shows the CMN block bus clocks held enabled by the
>     provider device.
> 
> The only variable separating the dying case from both surviving ones
> is the AHB/SYS gate after probe. What exactly performs the fatal
> access afterwards is the remaining open question - and this board is
> well suited to answer it, since it has full U-Boot control and can run
> experiment kernels from RAM. I intend to bisect that next (my current
> suspicion is that the CMN block AHB clock also feeds the register path
> of neighbouring blocks in the same region - MDIO at 0x88000/0x90000,
> uniphy at 0x98000, CMN at 0x9b000 - which would explain why the CCF's
> own runtime PM handling around the clk ops cannot help here). I am
> happy to run any experiment Jie would like to see on this hardware.
> 
> So to answer the question directly: I believe v3 is the right call now
> - three IPQ5018 boards, including a stock-image one, cannot boot
> without it and the cost of keeping two bus clocks of a small block
> enabled is negligible - with the exact-access root-causing tracked as
> a follow-up. If the follow-up ends up pointing at a cleaner fix (e.g.
> describing the real consumers of these bus clocks in DT), I will
> gladly send it as a successor.
> 
> Thanks,
> Stanislaw

I tested the latest linux-next code with the following changes:

Enabled the MDIO interface and added the Ethernet PHY as DTS below.
Enabled CONFIG_IPQ_CMN_PLL and CONFIG_MDIO_IPQ4019 as kernel modules.

--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi



+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi



@@ -219,12 +219,11 @@ mdio0: mdio@88000 {



                              <0x019475c4 0x4>;



                        #address-cells = <1>;



                        #size-cells = <0>;



+                       clock-frequency = <6250000>;







                        clocks = <&gcc GCC_MDIO0_AHB_CLK>;



                        clock-names = "gcc_mdio_ahb_clk";







-                       status = "disabled";



-



                        ge_phy: ethernet-phy@7 {



                                compatible = "ethernet-phy-id004d.d0c0";



                                reg = <7>;



@@ -241,11 +240,16 @@ mdio1: mdio@90000 {



                        reg = <0x00090000 0x64>;



                        #address-cells = <1>;



                        #size-cells = <0>;



+                       pinctrl-0 = <&mdio_pins>;



+                       pinctrl-names = "default";



+                       clock-frequency = <6250000>;







                        clocks = <&gcc GCC_MDIO1_AHB_CLK>;



                        clock-names = "gcc_mdio_ahb_clk";







-                       status = "disabled";



+                       ethernet-phy@1c {



+                               reg = <0x1c>;



+                       };



                };







                cmn_pll: clock-controller@9b000 {



@@ -427,6 +431,23 @@ uart1_pins: uart1-state {



                                drive-strength = <8>;



                                bias-pull-down;



                        };



+



+                       mdio_pins: mdio-state {



+                               mdc-pins {



+                                       pins = "gpio36";



+                                       function = "mdc";



+                                       drive-strength = <8>;



+                                       bias-pull-up;



+                               };



+



+                               mdio-pins {



+                                       pins = "gpio37";



+                                       function = "mdio";



+                                       drive-strength = <8>;



+                                       bias-pull-up;



+                               };



+                       };



+



                };

The board booted successfully on the IPQ5018 RDP platform.

# insmod ipq-cmn-pll.ko
#
# devmem 0x1856308
0x80000000
# devmem 0x185630c
0x80000000
#
# insmod mdio-ipq4019.ko
#
# ls -l /sys/bus/mdio_bus/devices/
88000.mdio-1:07/  90000.mdio-1:1c/
# ls -l /sys/bus/mdio_bus/devices/
total 0
lrwxrwxrwx    1 root     root             0 Jan  1 00:01 88000.mdio-1:07
->
../../../devices/platform/soc@0/88000.mdio/mdio_bus/88000.mdio-1/88000.mdio-1:07
lrwxrwxrwx    1 root     root             0 Jan  1 00:01 90000.mdio-1:1c
->
../../../devices/platform/soc@0/90000.mdio/mdio_bus/90000.mdio-1/90000.mdio-1:1c

