Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211718;
	b=yNfZjMoAH4WcGVFhr0jIW2NcSp7mOwTSWn1JT+SrobWWvfj0MUWF9Z0hwVFIUUpBi4hH
	 ygZMAGyDa68kvjTcE4AXUURauFONetab1PBtYoep5w/++r6N6NiBFome521Y9em5hSOnQ
	 ymw37wTkvWjViqCD4HspY4gsZsbTLTKJNrEll6XllOp0azLuz8GfL3zDpJY+AnWA3nLA5
	 aAn3EvFt1RhGuINlRSvRRdQrcU22CZP4sD7DeU6Dn+Pyte3wtqhQrFF9K2NFxBmru6gFt
	 fP8baLduv4smnrqHILyooZoH25I4GRZCQkng1HqrGrme3EwtSyP2UVVIcYvOxDgQOfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211718;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=PzuPUR91/m78fIpm/XjNz1Xs2Kf/txcuIq1pGbrFCzc=;
	b=Yg0yKh7Kb2yZVGKm+9Wm9qj4xR6t1dFTBeUWWtFAsahvc1XEM2BqPyMPfkkxcxCFP+O5
	 MFF8f/lr5LhR+TpAPZ//pP8Vz37hXq4ashcCsZemjjlYC2d/7A7p0ov4Q8kk1WnDs1fC/
	 pG2NHECAEf5p+zN+EINUb3CyHns6Q/3EuqWat1kev4Zkyz1zw5tCpdcGU0UiKZxu0Ewbh
	 4R8kFfmYaGyjReT1rWBluGXWdV6zKrIjbNZT2kQrnFtkt+7jY3zAsDMrmKWN2m1aLSPvC
	 88HztNpzch2c/kHBFIfGmoJ/Lr1i0Bz8SRfsahNZgskIYLniEyUc4RVJOCrC1uT1l3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7182F606A323;
	Mon,  9 Nov 2026 08:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7182F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8Bx69GCf_FqbL8dAA--.20041S3;
	Mon, 09 Nov 2026 16:08:34 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJAxmM15f_FqWiQzAA--.37920S3;
	Mon, 09 Nov 2026 16:08:34 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	zhanghongchen <zhanghongchen@loongson.cn>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH v9 1/7] thermal/drivers/loongson2: Fix negative trip conversion in set_trips
Date: Mon,  9 Nov 2026 16:08:16 +0800
Message-ID: <e1179acf645fdb6ea00e7e03248ee901927629d1.1794211535.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1794211535.git.zhoubinbin@loongson.cn>
References: <cover.1794211535.git.zhoubinbin@loongson.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxmM15f_FqWiQzAA--.37920S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEGCGrxOf4EQQAAsU
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw4xuFy3XFWxGw17ZF18JFc_yoW8CF18pa
	y3C34DArZrJr4qvw1DAayrXFZ8A343tFZrWF4xGw15Cws8J3yagryUtFyUZ3yfGFy8XFyY
	vr98trWDCF4DA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8W89tUUUUU==

The `MILLI` is defined as an unsigned long constant. When the
temperatures passed to loongson2_thermal_set_trips() are negative, the
expression `low / MILLI` triggers implicit conversion of the signed
operand to unsigned long, and the division is then carried out in
unsigned arithmetic.

For example, with a low trip of -40000 (milli-degree Celsius):

    -40000 / 1000UL = 18446744073709511   /* unsigned long */

After truncation to the 32-bit register field this becomes
1271310379, instead of the expected 60 (i.e. -40 + HECTO). Writing such
bogus value into the trip register leaves most of the upper bits set,
which may hit status/trigger bits and cause spurious thermal interrupts.

Use MILLIDEGREE_PER_DEGREE instead of MILLI so that the division is
performed in signed arithmetic.

Cc: stable@vger.kernel.org
Fixes: e7e3a7c35791 ("thermal/drivers/loongson-2: Add thermal management support")
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/thermal/loongson2_thermal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 4d40fc706a53..54ddee47cb32 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -108,7 +108,8 @@ static int loongson2_thermal_set_trips(struct thermal_zone_device *tz, int low,
 {
 	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
 
-	return loongson2_thermal_set(data, low/MILLI, high/MILLI, true);
+	return loongson2_thermal_set(data, low / MILLIDEGREE_PER_DEGREE,
+				     high / MILLIDEGREE_PER_DEGREE, true);
 }
 
 static const struct thermal_zone_device_ops loongson2_2k1000_of_thermal_ops = {
-- 
2.52.0

