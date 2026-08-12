Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA76283142;
	Wed, 12 Aug 2026 05:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786511967; cv=none; b=VtoFcVUfKdIWmAcmgwdBg94O81Ye35Yru+tnGrwwJFai2sYoB4EZLOpW9KvNHjISdxk+jINthV7yXkUDSkScRmWs+cj+GQJjyebyMPOBEnjRz03UinUHQsgva8v2Tp1OSBL4JvuyjVZr8OOWuxnPFlHjFa9ZdHip0nUVJZNuVa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786511967; c=relaxed/simple;
	bh=2xpjH+g9pbptV7fo74bLGyfjoP1ZcLE4XjR8OhCZ0jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ntaP9fDoF+TTczHwKHvhai4Ey05NEqmJdvk249rX3Fwqkbqo+wAR1J+wJmYsxeRAj2XYx5Cg3+Vez8MA7H0iqNtPBn4ScQRRSmQ6soGcmma+PRCPGbSizBlkS0qq+rRfPlOv6+pqvWh2Z/tmx77XL0H9itLlHyi7kxnn3+d5ieU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTUUTDyg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTUUTDyg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121FD1F000E9;
	Wed, 12 Aug 2026 05:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786511965;
	bh=mJ7HuryH5UMG3CrE/Icr7MoaIsMbA2vjbdUAFHazUK4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FTUUTDygov0Yy/2vXLVnYwr6eJ7nzIemTlJZdVn3BLv9k8MhkijQAO5V63t0RZ/72
	 +ETWGLUeG27zpk9yYRF0hrH0eIJndQ4jjhxdrbJm+kVwQOggqbO3zR3Mw1cG5et8Tz
	 lbF35a9PKqwnWDsxa89CiwNzFyv3t9IFFXn+Zm+yY80LPr0fod77848Omad7SceU5m
	 H1BSecaUHjnN91FnpybUm5zOBF8pqnE7M81RV8l/hzBuzPv7krEbeV/y5OlDK80qKG
	 SpFMwLWERVYIxWlU445u3c72mFsOyFxI6lA79MloJJboVsSHXIaQKdk4KzvQ1jOssH
	 6jS7gAJ5cYSOg==
Message-ID: <f2814e0c-15a9-4b7b-bd13-edca6c007e1f@kernel.org>
Date: Wed, 12 Aug 2026 06:19:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/22] arm64: dts: qcom: hamoa: Reserve low IOVA range for
 Iris
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Johan Hovold <johan+linaro@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Mansur Alisha Shaik <mansur@codeaurora.org>,
 Andy Gross <andy.gross@linaro.org>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Stephen Boyd <sboyd@codeaurora.org>,
 Yassine Oudjana <y.oudjana@protonmail.com>,
 Pierre-Hugues Husson <phhusson@freebox.fr>,
 Marc Gonzalez <mgonzalez@freebox.fr>, cros-qcom-dts-watchers@chromium.org,
 Matthias Kaehlcke <mka@chromium.org>,
 Douglas Anderson <dianders@chromium.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Aniket Masule <amasule@codeaurora.org>,
 Malathi Gottam <quic_mgottam@quicinc.com>,
 Rajendra Nayak <quic_rjendra@quicinc.com>, Jonathan Marek
 <jonathan@marek.ca>, Dikshita Agarwal <dikshita@qti.qualcomm.com>,
 Renjiang Han <quic_renjiang@quicinc.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Daniel J Blueman <daniel@quora.org>, stable@vger.kernel.org
References: <20260807-iris_iova_600mb_fix-v1-4-3996f67e33f9@oss.qualcomm.com>
 <ruow4uus64krlpy2gvm3g2d6rq5kgmgxnlhstmecil3gw7lhkd@2golvucd473l>
 <27f0b033-e940-4369-aaa0-f08426aac73f@oss.qualcomm.com>
 <tdgbfewnlj3xypfnyckivnd2b6667laapkcfs2vpnk74bh22aa@obasatns3jfr>
 <MHRdGybtgutWtIo4EOZisrGdCVgOj7AdOArjfuxCXTTNcc1o1v40eltpkDUqZl5sOY9tjRFaY6tc_OKvzrYJ4w==@protonmail.internalid>
 <429d5d1d-92d5-4949-9991-b092cc7e9937@oss.qualcomm.com>
 <181b02e3-831e-4461-9327-ab5646380a10@kernel.org>
 <73b26356-8ccb-4a81-b626-a96de5b13173@oss.qualcomm.com>
 <v7vlh2lgvluvacmxora6l7u5r3cbhr4xaqqlzqdli5jympfwxl@5qsqc354n4u3>
 <7caa7fd4-6732-4c80-8b8e-a0ed99631ba2@oss.qualcomm.com>
 <002ZtQRsWlMbVXarg5v4s8YbLGtxjWZJYhk47a6t1t-uTUXwA5ifUqzAaL1f4zKuffk9ig9c4v2vymXcQAj6AQ==@protonmail.internalid>
 <bkghekyhpporov7whqjd4s2oxaqd4dsjsgxn76vb7ezz67sbso@hrjpt2v4ejxz>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-US
In-Reply-To: <bkghekyhpporov7whqjd4s2oxaqd4dsjsgxn76vb7ezz67sbso@hrjpt2v4ejxz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/08/2026 01:17, Dmitry Baryshkov wrote:
>> You are well aware of them, but still asking the same. Reasons,
>> 1. We have been attempting the subnodes for almost a year with multiple
>> pushbacks from multiple maintainers. We are closer and working on it to post
>> for iris, followed by venus, once review is acceptable for iris.
> I think that we should have concentrated on it.  From my point of view,
> the subnodes solution is ready and the last obstacle was the
> under-informing commit message. As you can see, Rob has (had?) questions
> about this solution too.

Its taking too long.

I just suggested restricting concurrency but, that can't be right. The 
issue is IOVA - concurrency merely makes the bug more _likely_ to show 
up so in fact that won't work.

-rc1 hits soon, if sub-nodes isn't ready to go by that point there is no 
choice but to implement BROKEN or minItems, 100% up to qcom to decide which.

---
bod
