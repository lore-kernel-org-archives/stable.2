Received: from fraori-sdnproxy-3.icoremail.net (fraori-sdnproxy-3.icoremail.net [132.226.202.154])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE2F448B97;
	Wed, 23 Sep 2026 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=132.226.202.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790146729; cv=none; b=scOhPJ59i/AVjTvOoH8Xr1UQw2oOS6Rz1zOtNfv4CDNeOVhlPawy3Z7r91UPCl61ztWek8rBVWziJmxWys/7qWCgam4g86vocc9PwSxE/reXnbMw/wXg6c+/LqGJrYe6OuJdC5lepalHpcq+gAOnwdUkfwxz5kecgjdlEiDYVi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790146729; c=relaxed/simple;
	bh=pF9SxQQ9Z1XbgSAlSmM8GywSeHdVQviKAgrAU6XpWCs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nmE2jhbDdctfbsrg8dJIHV22IKSZZn2PbPgkenKTpqZSlTqh3bdFNuulhGRP8KiDD1fRKztnqsEP0iNA9S2EVnDt6W9GZwgplXyo985/DUX3IlbhZV+w1LTJa5jr4nsCmggjU6R+6seLlXRr+hwUgCyNLFjPvmiQQ8DOKJMoG1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=132.226.202.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.190.161.236])
	by mtasvr (Coremail) with SMTP id _____wCnRwiWeLNqVMIwAQ--.6120S3;
	Wed, 23 Sep 2026 14:58:31 +0800 (CST)
Received: from smtpclient.apple (unknown [10.190.161.236])
	by mail-app1 (Coremail) with SMTP id yy_KCgBXyKGWeLNq85qfBA--.49361S2;
	Wed, 23 Sep 2026 14:58:30 +0800 (CST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] HID: playstation: Fix DualShock4 dongle hotplug work
 use-after-free
From: Fan Wu <fanwu01@zju.edu.cn>
In-Reply-To: <20260923032634.417433-1-fanwu01@zju.edu.cn>
Date: Wed, 23 Sep 2026 14:58:20 +0800
Cc: linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 Song Li <songl@zju.edu.cn>
Content-Transfer-Encoding: 7bit
Message-Id: <81BEA2CA-2D05-4A0B-95C5-C67E017FBCC5@zju.edu.cn>
References: <20260923032634.417433-1-fanwu01@zju.edu.cn>
To: Roderick Colenbrander <roderick.colenbrander@sony.com>,
 Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)
X-CM-TRANSID:yy_KCgBXyKGWeLNq85qfBA--.49361S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?NDI/4AXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVCjTgEH9dVomQuWcozCBBFdsbiNRDgxIZy1BXBkJ/NUlPxEn5ZVZgKIbGTuX8n9gcE+
	7FR/EfKaheMfmSlzV2Wp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj9xXoW7JFWrKrW7Wr4kKw13Zw48Zrc_yoWxKwb_u3
	45Zry0gw1vgF47KFn8KF4fArnxta9rtry5Xw4rZr9av347ur98Wa9IvwnIgryxWw4DCasx
	Kr1j9rW7Cw1jkosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbT8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24l42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
	JbIYCTnIWIevJa73UjIFyTuYvjxU7gAwDUUUU

Please drop this patch.

__hid_input_report() returns -EBUSY when it cannot take
hdev->driver_input_lock, and hid_device_probe() and hid_device_remove()
hold that lock across the driver's ->probe() and ->remove() callbacks.
hid-playstation never calls hid_device_io_start(), so input reports
cannot reach dualshock4_dongle_parse_report() while
dualshock4_create() or dualshock4_remove() run. The window this patch
tried to guard does not exist, and the cancel_work_sync() calls that
were already there are sufficient.

The issue came from our static analysis tooling, which missed that
the HID core serializes the report path against probe and remove.

Sorry for the noise.

Fan Wu

