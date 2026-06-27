Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F2A70836
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 00:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782520326; cv=none; b=TsCd+jbcvTAJ7oZtJ0OOF8r+obOYOeGJAhD+rV+/BQ2dfoLlXarNdEmmS3J7bZUhmNuKox7lyfcZZrit2n4y1lo7YrNX4pDVALN47Y5jzACzTrXc1d8K339XSasVeSOxZX58TZvHdDMgdkYf3M3ByeY2Xer+kKOmDowjMMGtiCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782520326; c=relaxed/simple;
	bh=6LuQ8pggr4YAJuIBdtoIDwEpimEbXZr0dGgLbDqDObE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D12JjGTEX8kq0G+kq+xE53kjJJotA6V/m0rulRB4mo8xDaeZqQaFBufhGMwI5vUa/iin/xvLBIcRwt5BWn9Bu4ropR/WAjno8lTAyuvUMZjwgmGKFd3oml3mhoWcfffEHwgLZtcUXQg7TfJmq7I+I3wGTEOcMJtV7GPhYFZGfy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cM/mwgYM; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cM/mwgYM"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30c944aacbaso538179eec.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 17:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782520323; x=1783125123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=df2IUvs0nGKzMIEEP7Xdb2jOl5F8u2fTp9lEESg3Lgc=;
        b=cM/mwgYMOPTODkrGQzkjtWE0PZ4bLPLyCCDJgbhhuFYuJWTyYRfCt3Kj9nJmc94AmI
         pefWodEGndGGFGIAKLpYYJ6oy4CWTJGn10J1iHmGsoSgJkShFOzGcOTmBLdTA30ib7oR
         tpO42+gCfPO3yutaWyBbS71koGzwgbb/9w5zg/dHwIJJi1ZRkpzToc4en+3xL18YBskp
         FrSNK8GNpl6STUDcTbJMGIsxA221eEZPYEm3cfAG4vJzHm1CeDJwe1M3jbUk7bNiwqnk
         M23QVF3los6LmlkTzK0YYfgQCbt6RsU915V5YmrVONZ/NzDk2rQm3LJfFeZCv132jGeb
         LODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782520323; x=1783125123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=df2IUvs0nGKzMIEEP7Xdb2jOl5F8u2fTp9lEESg3Lgc=;
        b=HpkCLWDVRaEs53Ij87jUQtFx8JqFMBwXwKCzgDIt+GS8xJ3TML74/PlLT2KdsUXOlV
         yTHOiLnTdY0/9dqFTTIuxwpbuuGX+KzhNwSr+h2Dujq1Z0bG31hhMW25GLuLmlujlxXv
         lt2p3lsR7d+bjSB10R2guUdXfzevWraoS4oof0I/zgJj9zs+ITpvn+lUiBZe1YSWkZGV
         Jl7t0yjxpYYNtojWmdAGnye0ky06mafMvYV6jEzRxiq9ao2A4MLQeLEaoeNKwdM6pGGq
         NWfJgZA/qrTcy/qDJfTB1aFEyBvHU6VKjKEXzyLR3jJaUFWRyiN0PZd5t54UCvz3db4x
         VSgg==
X-Forwarded-Encrypted: i=1; AHgh+RqYv7140U8F1ndk+3Jn4xTjdPOI3f+AeVdVUJ0/8OG6ZGOxnE6mrZDkRI0XPWTnYz/RU4UDUZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YywzjV45KEORtZR0VgV5p10VvkmJaY97RapcGjIvDcSh17NG4/j
	Hu/q8FOKHIEaXd2Jv3cWjdsJ4ZYugw7PpdbGn0VNJYNUm3/UOoYFEMoC
X-Gm-Gg: AfdE7ckZ7N3SGiyNb5phqcdbUGBVYv+5xpKVMcPrbVZNTHqLi6gaYyCQO5gh7IV+KLz
	KWI6YedlwJuyvDWPKPS9oPRE5XDG7ALAlbJBmzW61r9RKYTMvtC3O+OHg5SeDlrJo31W49npi84
	SLzCpX+wGjTISq21KqToZrprl6w5OkHck7FFNH7GZ7D/tetSerpYnEX6f8/q4c3wmGZ4Ztdm/s3
	94xP/aVNTew29LlO9njQ9wUKmrqn1htZWyUC9hIZsJ610pfJKQRVUwB7V5QUheFVmahyrbjW0Cq
	tuvaJSMQ3m5/LR/YHXgmSsF+9XPQC4f8cT5nITny8xery8cF5lILGFtwQmxgC+kdVOagQDxeeRP
	r/oyxI9M11uFQj5yjKZAGNGJCqbZc6zfrZfUYdceIMKg0znsQwCd9+xnN7w2RUQzYTIhGyl9tSO
	hjnx9AIeIA33TMPUatk9CgJdnERnOldlpEy7p1/TGNJafRU7AQsbCACw==
X-Received: by 2002:a05:7300:e6c4:b0:30c:6d2c:2aa7 with SMTP id 5a478bee46e88-30c84fa683fmr8704109eec.20.1782520322738;
        Fri, 26 Jun 2026 17:32:02 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:3348:4970:ea3e:6159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c8b1a80sm21396227eec.18.2026.06.26.17.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 17:32:02 -0700 (PDT)
Date: Fri, 26 Jun 2026 17:31:58 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	sr@sladewatkins.com
Subject: Re: [PATCH 7.1 00/21] 7.1.2-rc1 review
Message-ID: <aj8WEfam__6fnNuM@google.com>
References: <20260625125613.243729608@linuxfoundation.org>
 <b7bd471b-e9da-4bfc-ad1d-24b378bd1e44@pobox.com>
 <aj7RmyBck8EkPn_s@google.com>
 <ab7df7bf-1b30-40c0-9463-a469abfa2bda@pobox.com>
 <aj7r1Eqt2SEnWsMZ@google.com>
 <626fc564-6f4b-430d-92f3-653981e3dcdd@pobox.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <626fc564-6f4b-430d-92f3-653981e3dcdd@pobox.com>

On Fri, Jun 26, 2026 at 03:23:12PM -0700, Barry K. Nathan wrote:
> On 6/26/26 2:17 PM, Dmitry Torokhov wrote:
> > On Fri, Jun 26, 2026 at 01:41:38PM -0700, Barry K. Nathan wrote:
> > > On 6/26/26 12:56 PM, Dmitry Torokhov wrote:
> > > > Hi Barry,
> > > > 
> > > > On Fri, Jun 26, 2026 at 10:56:21AM -0700, Barry K. Nathan wrote:
> > > > > (cc Dmitry Torokhov because this is related to two of your commits)
> > > > > 
> > > > > On 6/25/26 6:03 AM, Greg Kroah-Hartman wrote:
> > > > > > This is the start of the stable review cycle for the 7.1.2 release.
> > > > > > There are 21 patches in this series, all will be posted as a response
> > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > let me know.
> > > > > > 
> > > > > > Responses should be made by Sat, 27 Jun 2026 12:54:50 +0000.
> > > > > > Anything received after that time might be too late.
> > > > > > 
> > > > > > The whole patch series can be found in one patch at:
> > > > > > 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.2-rc1.gz
> > > > > > or in the git tree and branch at:
> > > > > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
> > > > > > and the diffstat can be found below.
> > > > > > 
> > > > > > thanks,
> > > > > > 
> > > > > > greg k-h
> > > > > > 
> > > > > Unfortunately, 7.1.2-rc1 breaks the Synaptics touchpad on my Lenovo
> > > > > ThinkPad T14 Gen 1 -- the pointer no longer moves when I touch the
> > > > > touchpad. Potentially relevant line from dmesg:
> > > > > 
> > > > > rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics, product: TM3471-020, fw id: 3972349
> > > > > 
> > > > > > Dmitry Torokhov<dmitry.torokhov@gmail.com>
> > > > > >        Input: rmi4 - refactor register descriptor parsing
> > > > > > 
> > > > > > Dmitry Torokhov<dmitry.torokhov@gmail.com>
> > > > > >        Input: rmi4 - fix register descriptor address calculation
> > > > > > > Both of these patches seem bad in my testing. Either one, individually,
> > > > > causes the pointer to no longer move when I touch the touchpad. If I
> > > > > revert both of them, then my touchpad works again.
> > > > > 
> > > > > I have not yet tested 7.0.14-rc1 or 6.18.37-rc1. However, the problem
> > > > > also reproduces on current mainline as of this writing (commit
> > > > > 51cb1aa1250c36269474b8b6ca6b6319e170f5a5).
> > > > Could you please try applying this debug patch and send me dmesg?
> > > Sure, I applied the patch on top of mainline, and the dmesg output is
> > > below.
> > Thank you! So I messed up and "Input: rmi4 - fix register descriptor
> > address calculation" is totally wrong.
> > 
> > Can you please revert it (keeping the debug patch) and try booting again
> > and if the touchpad still does not work post the dmesg again.
> > 
> > Thanks!
> 
> I did the revert, while keeping the debug patch. With this kernel, the
> touchpad still doesn't work for me, so here's the new dmesg.

Thank you. It looks like the firmware is a bit sloppy and the new
tightened checks are tripping on it. Please try this patch:


Input: rmi4 - tolerate short register descriptor structure

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Some touchpads (e.g. ThinkPad T14 Gen 1) have buggy firmware that reports
a register descriptor structure size that is too small for the number of
registers it claims to have in the presence map. The remaining bytes in
the structure are 0, which with the new strict bounds checking causes the
parser to fail with -EIO, aborting the device probe.

Tolerate such short reads by dropping the remaining (unparseable or
0-size) registers from the list instead of failing the probe,
preventing the driver from trying to use them.

Fixes: 0adb483fbf2d ("Input: rmi4 - refactor register descriptor parsing")
Reported-by: Barry K. Nathan <barryn@pobox.com>
Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_driver.c |   37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index a28eef1b765e..a58de7aad150 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -616,8 +616,8 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 	unsigned int presence_offset;
 	unsigned int map_offset;
 	unsigned int offset;
+	unsigned int num_registers;
 	unsigned int reg;
-	int i;
 	int b;
 	int ret;
 
@@ -657,7 +657,7 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 
 	memset(presence_map, 0, sizeof(presence_map));
 	map_offset = 0;
-	for (i = presence_offset; i < size_presence_reg; i++) {
+	for (int i = presence_offset; i < size_presence_reg; i++) {
 		for (b = 0; b < 8; b++) {
 			if (buf[i] & BIT(b)) {
 				if (map_offset >= RMI_REG_DESC_PRESENCE_BITS)
@@ -697,28 +697,41 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 	if (ret)
 		return ret;
 
-	reg = find_first_bit(presence_map, RMI_REG_DESC_PRESENCE_BITS);
 	offset = 0;
-	for (i = 0; i < rdesc->num_registers; i++) {
-		struct rmi_register_desc_item *item = &rdesc->registers[i];
+	num_registers = 0;
+	for_each_set_bit(reg, presence_map, RMI_REG_DESC_PRESENCE_BITS) {
+		struct rmi_register_desc_item *item = &rdesc->registers[num_registers];
 		int item_size;
 
+		if (offset >= rdesc->struct_size)
+			break;
+
 		item_size = rmi_parse_register_desc_item(item,
 							 &struct_buf[offset],
 							 rdesc->struct_size - offset);
-		if (item_size < 0)
-			return item_size;
+		if (item_size < 0) {
+			dev_warn(&d->dev,
+				 "%s: Failed to parse register %d descriptor, ignoring it\n",
+				 __func__, reg);
+			break;
+		}
 
 		item->reg = reg;
 		offset += item_size;
 
-		rmi_dbg(RMI_DEBUG_CORE, &d->dev,
-			"%s: reg: %d reg size: %u subpackets: %d\n", __func__,
-			item->reg, item->reg_size, item->num_subpackets);
+		if (item->reg_size == 0) {
+			dev_warn(&d->dev,
+				 "%s: Register %d has 0 size, ignoring it\n",
+				 __func__, item->reg);
+		} else {
+			rmi_dbg(RMI_DEBUG_CORE, &d->dev,
+				"%s: reg: %d reg size: %u subpackets: %d\n", __func__,
+				item->reg, item->reg_size, item->num_subpackets);
 
-		reg = find_next_bit(presence_map,
-				    RMI_REG_DESC_PRESENCE_BITS, reg + 1);
+			num_registers++;
+		}
 	}
+	rdesc->num_registers = num_registers;
 
 	return 0;
 }


Thanks.

-- 
Dmitry
