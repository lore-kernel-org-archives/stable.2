Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAED303CAE
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782503784; cv=none; b=f2+PR/LuzfEAMvdehTCwX3CwOyUalldsao9xI8wiwe/wzWJQ98ukIwQWcMgBXeYsV1tLAwXwIJUv3Sykxymn4ByBWlEHJEYLgG+AncVUpBRLJkaPUoaeahn8u6q1MhAS4gBJaCAWBypVEkyc3B5cm62W26B3pQv8DIzTB6hXPK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782503784; c=relaxed/simple;
	bh=vKCMYRw6PeAYacLS/YFX/j9UISD4ObDSppvkRqnhCIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVC0ABheQo4Qu/r74OKhHSAe6dbiG9/WZ1YUzF7xcu4ExSIC5sVkjg3R2DUZ49IUTktzdi2lob2DzoMhnmwqqdZqxOosHgAB8nrPz0oCQx5+3I9sUJQ/bPQ8rZwV9e8WIVBxpwjS8sxgtAJowneBuRr/1qeJdn47nwZSvGNwZSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bePizJt7; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bePizJt7"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30c6874d295so853256eec.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 12:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782503782; x=1783108582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0bU0QoVcc0wXfhe1dR98a619nSbxI4Rk3dUoG7XOYOg=;
        b=bePizJt7lYJH7p6H81E9w2aDwTdvScs5Fdj0/1wWRsLEDSJw13+l8mf3qRA+KWGLfo
         QsLdHfxwztMHjQBAUNNVyqqDUcRHqphpNlEfpnhpMMshaT86M/HBn41FNQ7jJ7HXXy6y
         sKx2iXEsZ0j9IICXy5Kgv/Tzes8vAhmMvPw8n0p7SUnI9vxicDgWMBZKvTgjB1zoXM4F
         ZOVE7wTlVEzlL0BgkowwemKcoHK13JD7J0ZzKSIV3f2Xnn26b1n8vjm446tHVsMPRlAm
         /E9zYO7Go4IkwDLfzjfn4ece22qK0tRWmL7+5GoFybgd/HJnZ7+Cke8VQbc67MH90J/b
         BcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782503782; x=1783108582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bU0QoVcc0wXfhe1dR98a619nSbxI4Rk3dUoG7XOYOg=;
        b=Z3p0inZzmdPCtizr6m05AqAMZdPTF4TAAtw0uToRnZfDD3wzhyIV0Wb7K3pzr6QjkU
         9vgGbScfuahO1gkDxxr5uHJmEQeP4zGhqhKxXKmnytYzIPuU184NBemB/9yVu5FKWNz8
         5rwtVyhRFCKkkq/X2Ha+W1KGwfXLL3H9p9WzyUuKcWanZN0NLhrRZsNr3ldrdNmme4h0
         tXZHVdHjORmiIeI7oTfY77mj8yBqgS5GSH109Qzx3wOExMaGi0QqLieMA10Fxr/9D9EQ
         oCVAIwZhGKTlxUQ5CuVomPdeR+N8+bLJ9Z3CzugAtbzaFUNR53UolGO+MQSQISCJ9Own
         GRYw==
X-Forwarded-Encrypted: i=1; AHgh+Rp6o6LeGZO/yWpa33E+fPouGso30MCZ/ViOFl9RRAU2sdOwOA1ck+hbh9Q+alg6aZBT7WZ84hQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzytcXv8z2eKaNWXwwT70poEA/gzXfZ0a9+QPDofsvr1jZNe8F/
	mh9EERJqWlOwZjTFOQ17/F3ckLPRnEqIyqZnZ/X2N1rYqlOtXvKAe3yk
X-Gm-Gg: AfdE7clIO3IUeQsPakBEgqlZMoaFZR9jZskHcLNBa8Q2iolOMVGQ1prZK0A33vNM7Bj
	bZttaJQNi8UnzrkYrdunXmdowArcMqep7YUb4QJgU2yPp/RQ1vBB54MP0kHrEw73PwQ/kxObITi
	6CIHHFXorIZ1V0g4fo20IjKB8qWCJNWHtTCSGpfnk5iQNLDb37M/VHJf5oAr1+j1aymPE/VPfPt
	15KDTJjfRIH7LZMzDBvQq2aDGccDnfJufEFHRjnZg/F5RMDonmERuR7+2sOJPIUtqHfF48KvSAO
	+HuTv7t6wJqcih/dtopBte25kSHutajs9sAGnPIJpYUP/QfTz6ezpPRcrZNsnN5IHZdPGBGrZfT
	mwCXieE+2t7FmN0UyKtqjuVF42XCOlOmZN6RthsVqQrGGeY161eNZwEZYGa5frEXWgCTEetr6B+
	SvaaSlc594XkZzl1juXzArpuy1op+fB2PANhJeXLZF+23vLXagRtFEVWXamA6+ukpg
X-Received: by 2002:a05:7300:372c:b0:30b:c0b4:db42 with SMTP id 5a478bee46e88-30c85a5cd27mr8794234eec.11.1782503782154;
        Fri, 26 Jun 2026 12:56:22 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a474:bf4a:4966:8d97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c944d004esm11772037eec.22.2026.06.26.12.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 12:56:21 -0700 (PDT)
Date: Fri, 26 Jun 2026 12:56:17 -0700
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
Message-ID: <aj7RmyBck8EkPn_s@google.com>
References: <20260625125613.243729608@linuxfoundation.org>
 <b7bd471b-e9da-4bfc-ad1d-24b378bd1e44@pobox.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7bd471b-e9da-4bfc-ad1d-24b378bd1e44@pobox.com>

Hi Barry,

On Fri, Jun 26, 2026 at 10:56:21AM -0700, Barry K. Nathan wrote:
> (cc Dmitry Torokhov because this is related to two of your commits)
> 
> On 6/25/26 6:03 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 7.1.2 release.
> > There are 21 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat, 27 Jun 2026 12:54:50 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.2-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Unfortunately, 7.1.2-rc1 breaks the Synaptics touchpad on my Lenovo
> ThinkPad T14 Gen 1 -- the pointer no longer moves when I touch the
> touchpad. Potentially relevant line from dmesg:
> 
> rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics, product: TM3471-020, fw id: 3972349
> 
> > Dmitry Torokhov<dmitry.torokhov@gmail.com>
> >      Input: rmi4 - refactor register descriptor parsing
> > 
> > Dmitry Torokhov<dmitry.torokhov@gmail.com>
> >      Input: rmi4 - fix register descriptor address calculation
> 
> Both of these patches seem bad in my testing. Either one, individually,
> causes the pointer to no longer move when I touch the touchpad. If I
> revert both of them, then my touchpad works again.
> 
> I have not yet tested 7.0.14-rc1 or 6.18.37-rc1. However, the problem
> also reproduces on current mainline as of this writing (commit
> 51cb1aa1250c36269474b8b6ca6b6319e170f5a5).

Could you please try applying this debug patch and send me dmesg?

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 49a59da6a841..65095257e3c3 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -569,27 +569,35 @@ static int rmi_parse_register_desc_item(struct rmi_register_desc_item *item,
 	unsigned int map_offset = 0;
 	int b;
 
-	if (offset >= size)
+	if (offset >= size) {
+		pr_err("%s: error: offset >= size (%d >= %zu)\n", __func__, offset, size);
 		return -EIO;
+	}
 
 	item->reg_size = buf[offset++];
 	if (item->reg_size == 0) {
-		if (size - offset < 2)
+		if (size - offset < 2) {
+			pr_err("%s: error: size - offset < 2 (%zu - %d < 2)\n", __func__, size, offset);
 			return -EIO;
+		}
 		item->reg_size = get_unaligned_le16(&buf[offset]);
 		offset += 2;
 	}
 
 	if (item->reg_size == 0) {
-		if (size - offset < 4)
+		if (size - offset < 4) {
+			pr_err("%s: error: size - offset < 4 (%zu - %d < 4)\n", __func__, size, offset);
 			return -EIO;
+		}
 		item->reg_size = get_unaligned_le32(&buf[offset]);
 		offset += 4;
 	}
 
 	do {
-		if (offset >= size)
+		if (offset >= size) {
+			pr_err("%s: error in loop: offset >= size (%d >= %zu)\n", __func__, offset, size);
 			return -EIO;
+		}
 
 		for (b = 0; b < 7; b++) {
 			if (buf[offset] & BIT(b)) {
@@ -625,9 +633,11 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 	 * The first register of the register descriptor is the size of
 	 * the register descriptor's presence register.
 	 */
+	pr_info("%s: starting read at addr 0x%04x\n", __func__, addr);
 	ret = rmi_read(d, addr, &size_presence_reg);
 	if (ret)
 		return ret;
+	pr_info("%s: size_presence_reg = %d\n", __func__, size_presence_reg);
 	++addr;
 
 	if (size_presence_reg < 1 || size_presence_reg > RMI_REG_DESC_PRESENCE_REGS_MAX)
@@ -643,7 +653,10 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 	ret = rmi_read_block(d, addr, buf, size_presence_reg);
 	if (ret)
 		return ret;
+	pr_info("%s: presence reg: %*ph\n", __func__, (int)size_presence_reg, buf);
+	
 	addr += size_presence_reg;
+	pr_info("%s: advanced addr to 0x%04x (after skipping presence reg)\n", __func__, addr);
 
 	if (buf[0] == 0) {
 		if (size_presence_reg < 3)
@@ -654,6 +667,7 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 		presence_offset = 1;
 		rdesc->struct_size = buf[0];
 	}
+	pr_info("%s: struct_size = %ld\n", __func__, rdesc->struct_size);
 
 	memset(presence_map, 0, sizeof(presence_map));
 	map_offset = 0;
@@ -670,6 +684,7 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 
 	rdesc->num_registers = bitmap_weight(presence_map,
 						RMI_REG_DESC_PRESENCE_BITS);
+	pr_info("%s: num_registers = %d\n", __func__, rdesc->num_registers);
 
 	rdesc->registers = devm_kcalloc(&d->dev,
 					rdesc->num_registers,
@@ -693,10 +708,14 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 	 * register and a bitmap of all subpackets contained in the packet
 	 * register.
 	 */
+	pr_info("%s: reading struct_buf from addr 0x%04x, size %ld\n", __func__, addr, rdesc->struct_size);
 	ret = rmi_read_block(d, addr, struct_buf, rdesc->struct_size);
 	if (ret)
 		return ret;
 
+	print_hex_dump(KERN_INFO, "rmi_struct: ", DUMP_PREFIX_OFFSET, 16, 1,
+		       struct_buf, rdesc->struct_size, false);
+
 	reg = find_first_bit(presence_map, RMI_REG_DESC_PRESENCE_BITS);
 	offset = 0;
 	for (i = 0; i < rdesc->num_registers; i++) {
@@ -712,9 +731,8 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 		item->reg = reg;
 		offset += item_size;
 
-		rmi_dbg(RMI_DEBUG_CORE, &d->dev,
-			"%s: reg: %d reg size: %u subpackets: %d\n", __func__,
-			item->reg, item->reg_size, item->num_subpackets);
+		pr_info("%s: parsed item %d: reg: %d reg size: %u subpackets: %d\n", __func__,
+			i, item->reg, item->reg_size, item->num_subpackets);
 
 		reg = find_next_bit(presence_map,
 				    RMI_REG_DESC_PRESENCE_BITS, reg + 1);

> 

-- 
Dmitry
