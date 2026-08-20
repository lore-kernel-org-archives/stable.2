Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FA52EAD15;
	Thu, 20 Aug 2026 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787215993; cv=none; b=SWe5rMpKW3i7wPy5LyzWDyXX1GWWcLaVMCxXD9t2z+nC2xkyurP8QCeX4WDNvJKZJFWXAcnBJjKMI1csFtJ02c5kq/4beqCoSnO50RDj4YaozaDhRMMf5JX8V7X14qqu6rmf0hr7xlrqhpyI5KGCpC49tJRlOFRIUgQixZeHZV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787215993; c=relaxed/simple;
	bh=i1KazAqUYsojNEEZaLoMJxR/zL25UZf7ooboUUp5oDY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eFmecIYbhpdm9JyfVJgBk4XSLf8Jv0FJcBfvnY9lAqGcagrJoUd4CXS2Uu9kdQBhQRotFoa527Rk3SMkQmaSZ4/HMhg7Mcc/gCJq1pcynslB6iQ2Sd29MO5yc/sGiHOzWMSRepGCdS97aoO1RKPS4euC2c/LpOcgUGWnrGUo8os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.97.62.103])
	by mtasvr (Coremail) with SMTP id _____wA3IT9swIZqa_OsAA--.3792S3;
	Thu, 20 Aug 2026 16:53:01 +0800 (CST)
Received: from smtpclient.apple (unknown [10.97.62.103])
	by mail-app1 (Coremail) with SMTP id yy_KCgBHS6VswIZqVj0DBA--.21741S2;
	Thu, 20 Aug 2026 16:53:00 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] usb: typec: qcom-pmic-typec: disable cc_debounce_dwork on
 stop
From: Fan Wu <12321260@zju.edu.cn>
In-Reply-To: <e06004a4-4ed8-46f4-a949-8cece1348ddb@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 16:52:50 +0800
Cc: Fan Wu <fanwu01@zju.edu.cn>,
 linux-usb@vger.kernel.org,
 bryan.odonoghue@linaro.org,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0C4B5340-A0DD-4A8D-B891-97A7303A6064@zju.edu.cn>
References: <20260819161950.77858-1-fanwu01@zju.edu.cn>
 <e06004a4-4ed8-46f4-a949-8cece1348ddb@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: Apple Mail (2.3774.600.62)
X-CM-TRANSID:yy_KCgBHS6VswIZqVj0DBA--.21741S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?AVE4jQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVCjTgEH9dVomQuWcozCBBEHgsDLPPt47ASGbQSG6TVxUP6ts+N1MwSADl3GtbYMByGt
	b6KLQD6mlxSJcUgj5u3N5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw45Xry3WF17Ar1fKFyfuFX_yoW8Gr1fpa
	93Jr90k3ykZFWv9F17KwnrAFyrGr13GrW8Jr1UGrWxAan8GrWftrWFqr4FvF1UCrWkWasI
	yFWUtFyDuay3tabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxU7gAwDUUUU



> On Aug 20, 2026, at 16:13, Konrad Dybcio =
<konrad.dybcio@oss.qualcomm.com> wrote:
>=20
> Doesn't this make disable_irq() get called undesirably?
>=20
> Konrad

Hi Konrad,

Thanks for pointing this out.

On the port_start() failure path the port IRQs have indeed not been
enabled: they are requested with IRQF_NO_AUTOEN, and the enable_irq()
loop is the last step in port_start(). Routing that path through
port_stop() therefore adds a nested disable_irq() on already-disabled
IRQs. __disable_irq() only acts when the depth goes 0 -> 1, so this
is just a counter bump on that leg =E2=80=94 no hardware access, no =
warning,
and devm frees those IRQs right after on the same unwind. But I agree
it is not an ideal cleanup contract.

The reason I routed it through port_stop() is to make sure
cc_debounce_dwork is disabled and drained before tcpm_unregister_port().
tcpm_register_port() runs before port_start() and may already have
queued the TCPM state machine; that worker can call set_cc() or
start_toggling() and arm the delayed work even when port_start() later
fails.

If you find the extra disable_irq() undesirable I will revise the
cleanup so the failed-start path only disables/drains the delayed work,
leaving port_stop() for the paths where the port was actually started,
and send an updated patch.

Thanks,
Fan=

