Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDF53002D1;
	Thu, 20 Aug 2026 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787234077; cv=none; b=L1g2xhyMO1+jXpJd6YR7PVOBbH9JScW/F3TqTVLIhZHMO2fBYc1jzRjQDPdRuaHsTERTGva38Bu3BtdtOUJ2tZLOUFU7cEdKMNNTtvkvcxkS8ap3D3bHg38mtboIeTPtTaGazIEWSWqacMABbMuUsKQ0P5k1O2IRTo8xl9sDoSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787234077; c=relaxed/simple;
	bh=wrba2UJ86qo1PVuFl2HwutZLudLXaonc7ur9SlppQn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q848bufJbHRx0F4mbO2nDbAo+0CGEqfaIe1aJv/YbPF2T5h+10drhZbgyjdLKbKk7wN02b98C/d+Hz4ekCOq1WF3HzmyGZQZHC6S3XzMKzjB/mEhCZKvpyTghSgREbrfUZR1/sEd87cW7YOvpCVMrC7Y7fAF2l0hiRDGueMta6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wBHXnwNB4dqrAauAA--.5917S3;
	Thu, 20 Aug 2026 21:54:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with SMTP id zS_KCgCXgncNB4dq4qKJBA--.53615S2;
	Thu, 20 Aug 2026 21:54:21 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux-usb@vger.kernel.org
Cc: bryan.odonoghue@linaro.org,
	heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH v2 0/2] usb: typec: qcom-pmic-typec: cc_debounce_dwork lifetime fixes
Date: Thu, 20 Aug 2026 13:53:05 +0000
Message-Id: <20260820135307.153773-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819161950.77858-1-fanwu01@zju.edu.cn>
References: <20260819161950.77858-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgCXgncNB4dq4qKJBA--.53615S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?gqmj7wXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WNeoIa8HzmzMWM8lWt4H0+dgkqcYy6hAI3JzeV6+CAacnY9
	YJ/ZOx+MvV2CKLice6up9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj9xXoWrtrykCr15CFWfXFWrAF45CFX_yoW3urb_Za
	48t3y8uw4UZFn2v3WUWFyUA34ftFy3Xa45tFnYgF40k3s8KFnxGa9FyrZ3Ar1Sk3yFyFnr
	Ga1DZ34vvrs29osvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbT8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24l42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
	JbIYCTnIWIevJa73UjIFyTuYvjxU2EoXUUUUU

This is v2 of "usb: typec: qcom-pmic-typec: disable cc_debounce_dwork
on stop", split at the "also" as Bryan asked: patch 1 fixes the
stop/remove path, patch 2 the probe-failure path.

Changes in v2:
- Split the probe-failure handling into its own patch (Bryan).
- The failed port_start() path now drains the delayed work at the
  port_start() error exit instead of unwinding through port_stop(), so
  the IRQF_NO_AUTOEN IRQs, which are only enabled at the end of a
  successful port_start(), are not disabled unnecessarily (Konrad).

Fan Wu (2):
  usb: typec: qcom-pmic-typec: disable cc_debounce_dwork on stop
  usb: typec: qcom-pmic-typec: drain cc_debounce_dwork if port_start()
    fails

 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c | 5 +++++
 1 file changed, 5 insertions(+)

