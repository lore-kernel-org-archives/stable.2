Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA66223336;
	Fri, 16 Oct 2026 03:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792122316; cv=none; b=H0gWVWqBoT/gm8E8hpVPqVvMHdaseS5vPF3v705zgSGoPM/iZPQQ3DpG43bWHplmy0HEwvRPAl/jgLumpLw9V5B/BzLwue/W4HuKJH8cIzJpy1XIIiO+2Xy5Mos8ilaJVG0Uki3DQlCJcVCceUzcayTyTqY1ux1PWBr3EhVHbpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792122316; c=relaxed/simple;
	bh=DTPI8cTkKJkMRR3tgCCU1MkTp3aWiFtYFgB2neHV2YU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UX4s53W42jAAYYp03CAe9FsTKRqzeEjmLjEx7LhhIeXvr1aOSZlz8UCmzsVhxdJxmqO+/6omuNMjxAJvc2XVLihg+RSisd5EiCY+I4n/GCHn+HysjjI/7pmRAx67nN3Uz3o2zDcEQvPrllHt6gXuRCAUcihQg1N01bvm31H2fEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (unknown [127.0.0.1])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4j5VwF1y1Xzb0pbD;
	Fri, 16 Oct 2026 11:36:13 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.140.201])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4j5VwC581Nzb0pbf;
	Fri, 16 Oct 2026 11:36:11 +0800 (CST)
Received: from [10.29.8.50] ([10.29.8.50] [10.29.8.50])
	by zhaoxin.com (8.30) with ESMTP0264a61b2a04fa418478202609a85106
	Fri, 16 Oct 2026 11:36:11 +0800
X-Eyou-Smtpauth: weitaowang-oc@zhaoxin.com
X-Eyou-EnvelopeSender: weitaowang-oc@zhaoxin.com
X-Eyou-From: zhaoxinweitaowangoc <weitaowang-oc@zhaoxin.com>
From: "=?UTF-8?B?V2VpdGFvV2FuZy1vYw==?=" <weitaowang-oc@zhaoxin.com>
Message-ID: <316900d3-2ce8-4391-ad8f-556bb5540c2a@zhaoxin.com>
Date: Fri, 16 Oct 2026 11:36:10 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IFvmraTkuLrlpJbpg6jpgq7ku7Yg6LCo6Ziy6aOO6ZmpXSBSZTog?=
 =?UTF-8?Q?=5BPATCH=5D_x86/apic/msi=3A_Fix_MSI_interrupt_affinity_configurat?=
 =?UTF-8?Q?ion?=
To: Thomas Gleixner <tglx@linutronix.de>, Koichiro Den <den@valinux.co.jp>
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
 WeitaoWang@zhaoxin.com, wwt8723@163.com, CobeChen@zhaoxin.com,
 stable@vger.kernel.org
References: <20260928164839.6381-1-WeitaoWang-oc@zhaoxin.com>
 <6mg2eqdehsmb5fh6hf7icsha2547xfdfvulnycawiit2czhhmh@6bbmicaoz2zd>
 <87jynid352.ffs@fw13>
Content-Language: en-US
In-Reply-To: <87jynid352.ffs@fw13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Eyou-Sender: <weitaowang-oc@zhaoxin.com>

On 10/16/26 06:12, Thomas Gleixner wrote:
> On Wed, Sep 30 2026 at 01:29, Koichiro Den wrote:
>> On Tue, Sep 29, 2026 at 12:48:39AM +0800, WeitaoWang-oc wrote:
>>> commit b56ebe7c896d ("x86/apic/msi: Fix misconfigured non-maskable MSI
>>> quirk") try to fix the issue of misconfigured non-maskable MSI quirk.
>>> For non-maskable MSI interrupts, use the slow path to fix the MSI affinity
>>> race. Maskable MSI interrupts use the direct path to update configuration
>>> info. However, the current code logic is the opposite as only maskable
>>> MSI interrupts will enable reservation mode.
> 
> Please read:
> 
>    https://docs.kernel.org/process/maintainer-tip.html#changelog
> 
> and restructure and reword the changelog accordingly. The above is
> incomprehensible word salad.

Hi Thomas,

Thank you for the suggestions. I realize the problem description in my
previous patch needed to be more precise. Before posting v3, I have
updated the change log as shown below. Could you please take a look?
If this looks good to you, I will send out the next version.

From: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
Subject: [PATCH v3] x86/apic/msi: Fix MSI interrupt affinity configuration

The two step update sequence in msi_set_affinity() is required for MSI
interrupts which cannot be migrated atomically, i.e. devices which do not
provide MSI masking. The MSI message update writes address and data
registers separately, so such a device can raise an interrupt in between,
which results in a message built from half updated state: A stray
interrupt on a stale vector and a possibly lost device interrupt.

The update sequence is selected by a per interrupt quirk flag, which is
set for interrupts which cannot use reservation mode. Reservation mode is
only enabled for maskable interrupts, i.e. devices which provide MSI-X or
mask support, so the quirk flag is the inverse of the reservation mode
bit.

The removal of the quirk flag replaced the flag check with a reservation
mode check, but dropped the negation of the removed condition:

       - if (!irqd_msi_nomask_quirk(irqd) || ...)
       + if (!irqd_can_reserve(irqd) || ...)

As the quirk flag is the inverse of the reservation mode bit, the
replacement inverted the condition and selects the wrong update path for
every interrupt: Non-maskable interrupts take the direct update path
again, which reopens the race, while maskable interrupts needlessly go
through the two step update.

Restore the original condition so that the direct update path is selected
when reservation mode is enabled, which also matches the comment above the
check: Direct update is possible when the MSI is maskable, which is the
case when the reservation mode bit is set.

Fixes: b56ebe7c896d ("x86/apic/msi: Fix misconfigured non-maskable MSI quirk")
Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
Reviewed-by: Koichiro Den <den@valinux.co.jp>
Cc: <stable@vger.kernel.org> # v6.1+
---
  Changes in v3:
   - Rework the changelog as requested by Thomas:
     https://lore.kernel.org/all/87jynid352.ffs@fw13/

  Changes in v2:
   - Change the Fixes tag to b56ebe7c896d ("x86/apic/msi: Fix misconfigured
     Dnon-maskable MSI quirk")
   - Update commit messages for clarity

   - Link to v1: https://lore.kernel.org/all/20260928164839.6381-1-WeitaoWang-oc@zhaoxin.com/
   - Link to v2: https://lore.kernel.org/all/20260930155213.4380-1-WeitaoWang-oc@zhaoxin.com/

    arch/x86/kernel/apic/msi.c | 2 +-
    1 file changed, 1 insertion(+), 1 deletion(-)

   diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
   index 66bc5d3e79db..da5f44a80313 100644
   --- a/arch/x86/kernel/apic/msi.c
   +++ b/arch/x86/kernel/apic/msi.c
   @@ -62,7 +62,7 @@ msi_set_affinity(struct irq_data *irqd, const struct cpumask *mask, bool force)
          * - The interrupt is not yet started up
          * - The new destination CPU is the same as the old destination CPU
          */
   -     if (!irqd_can_reserve(irqd) ||
   +     if (irqd_can_reserve(irqd) ||
             cfg->vector == old_cfg.vector ||
             old_cfg.vector == MANAGED_IRQ_SHUTDOWN_VECTOR ||
             !irqd_is_started(irqd) ||
  --
  2.32.0

Thanks
weitao

