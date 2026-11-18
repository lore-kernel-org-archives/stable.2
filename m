Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019007;
	b=mak9xCuD7JEyaRmDt8h71N8dMXnOHuwCeOGBS9YwNM6lv/hyEKHoaXKEVgVq42XNDk/c
	 KfpD7jq+OZi/NTI3iOMdK7gvwiD6adWJJUfkKVHtuzXRXBJYqZKiWkK/syQFdspfNN4AL
	 drL78CiXhC34lJEA7Xon7YEMcO80AQOV3xkUuyOmyhWDy3ztg4o4qj4G2q4vR/qPS1mYZ
	 A9XCsa3TuIywuSGLC3I8rYY3ATRnk1f2vB3xJQJoDOUN/xSzhk7d3IlKGXGveisHTbd8V
	 D8njAkM7WG0ABVw1cV0TTuUkqyJnPhXK7avJeGaoCVQJxqq4X8TSWZlIqZMdb5Ae6LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019007;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=TghilNVkwbKH2zAVmKDZkVzO+5fujCP4ET+Mg8Ax8Os=;
	b=BO3AKs7pceJwyPqk3Usul98a58QDffsXAOtSVuF3bA/5jF1luY+wCKNoavJwI9/Ih6ED
	 kh6OEPhn9OwUE3lN02mMpzZKgG3cVYKkVTDnQyuRtt7gBlv1aW1iWME6LTrf4hmKkyjN0
	 t1oE2bJmYJ/aUmEpQn+VbqE0atixsCfrQZr8hloDb5iEVDSyo9yK6lCiSgJUp+ITji7+O
	 jJABXy4uJwPNotrgQygefyyvo20tVBR9IPv+mhD8oU/ZSuzrTZV1TCrSsdKOSg0Mi3I0b
	 w74I1z1tdKEf5on9g+xyMXMOiyO0uZKc5u+uI3wtpFgxyzJkE0s2zGJ1TQPYOsBrA7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Z0Hp5GIm;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3807C606A32C;
	Wed, 18 Nov 2026 16:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3807C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Z0Hp5GIm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795019005;
	bh=SpKKAxZ7e8O13VXr++rojMKx6yhQT3thaJt3o0CVOPs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z0Hp5GImTdw3KSMbcw6Tmhrurp4PDt+FjyfQuyUDlCgmQE0GwNNBF4bst8VbAdkzU
	 SV1q3F3VBPryVLo0rH9svtYt6gIYzyUr5CuMjo+4kDLs7tbJgYOX15KUd8sIGHFd2S
	 E85qbpPmDHbu2md9nr3aFcUmfFxDBGlLbJ8iWvUYv/GSlOZ+i00BSpCJjr/qlsyqth
	 v63LMD6X7SN3HshiMU4c9vGj3df/YedeD6EAb/TIjn+lTlu8QCz431hukr+QpUKGPs
	 YldYY2MRAZHvi1dF5wXquUasXaaLiidm/Wi/zoo0LRJilk0fQQB0RxJOzdoyqfO4jP
	 Jd1G+ZQ6txMcw==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 17C2317E07EC;
	Wed, 18 Nov 2026 17:23:25 +0100 (CET)
Message-ID: <23e20395-2b5f-44b7-a081-f57cca18b08b@collabora.com>
Date: Wed, 18 Nov 2026 17:23:24 +0100
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
Subject: Re: [PATCH] power: supply: mt6360_charger: Set the input voltage
 limit in CHG_CTRL6
To: i@udp0.com, Sebastian Reichel <sre@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org
References: <20261107-mt6360-charger-mivr-v1-1-ae6fcfb21bb9@udp0.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20261107-mt6360-charger-mivr-v1-1-ae6fcfb21bb9@udp0.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/26 12:09, Rui Cao via B4 Relay wrote:
> From: Rui Cao <i@udp0.com>
> 
> mt6360_charger_set_mivr() updates the MIVR field (bits 7:1) of
> CHG_CTRL3, but MIVR lives in CHG_CTRL6, where mt6360_charger_get_mivr()
> reads it and MediaTek's own MT6360 charger driver writes it. CHG_CTRL3
> holds the input current limit (AICR, bits 7:2) instead.
> 
> Writing input_voltage_limit therefore never changed the voltage limit
> and replaced the input current limit with the MIVR selector: 4.5 V, for
> example, set AICR to 250 mA.
> 
> Write the MIVR field of CHG_CTRL6.
> 
> Tested on a Redmi Note 13 5G (MT6833 with an MT6360): with this change,
> writing 4.6 V to input_voltage_limit only moves CHG_CTRL6 from 0x0d to
> 0x0f and reads back as 4.6 V, while CHG_CTRL3 stays at 0x72 and
> input_current_limit at 1.5 A.
> 
> Fixes: 0402e8ebb8b8 ("power: supply: mt6360_charger: add MT6360 charger support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rui Cao <i@udp0.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
