Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F373A4F46
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 20:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781296074; cv=none; b=htmhGKFEEAMiUfNmMrbqO1ND+TGqRmeF1AFwNttZvfDUrTMV71x/f11ZdAPZktQmtGKUXcTIzMI5hAwEgIp9GhlFSzWxrLKoeD6AlyGuUoqdFGxYRq0nYpW3HjtjBS39l8fExM3sxWufxIsVbpQV7d/Xl4FWgUcECodLIHqLmtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781296074; c=relaxed/simple;
	bh=N3nic8JmeC1ouJbyETsDlLm18jMUO230zcLlyspEUFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpY4w5AHzBFkL6DaTU6qKIgRqQKmm9dCYq9V0MB33Iph7+8uWw7uBc3R7RvBqS3Dd6ENAIdb76pnundy2QHPDjayzrxnVLWvypXEk3uT074cW8TXxNHXWOdX1uFyxNBAmP+l1lYP6q8MsyAYNIj0XLfbbOlNRBfZm4x0hnQp+uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=o8lbDGsH; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="o8lbDGsH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781296062; bh=mxrm+dl2sD1cDmi3XtnLbtaSzLTSu6lFdCHpekktzQs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=o8lbDGsHRdsbfXVccvSwxUpdn46Y3AE8srpeFsMWs0sCJuuilu2aHbvj0wLSf3eyx
	 7KSnazjLh3olfO+BTg3zWALRrq/7/mDJTY1zahHU8iluRKg8Ekk6ajbUqiACfrwtT0
	 tBVHsk3OotyU8PaN+KjcNTH6/kQocLQOfP3dIoXU=
Received: from [192.168.1.102] ([183.95.73.181])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 6E6B18BE; Sat, 13 Jun 2026 04:27:38 +0800
X-QQ-mid: xmsmtpt1781296058t3kwpnw9i
Message-ID: <tencent_CC4B1079E0461B8950A0CA98790792059109@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLY/8ptFdiYfot3PH0aAZVgSDFvrcw22vklIzEbZ0gzuYGs81xlU
	 ktucM2XYWZaLv//f9Koixmr2ax1DUFXYECuFQCz2V5fOXaVCK46BD6KzM0Lcpa7czl0nIuppETxi
	 I9VShB39j9aBS3nJ737Vbl0N2LrBt1f03R5j2rI74R2vj/78yCNbDB5bJoPa0T6FNosceKhDz3cb
	 ZyMUR/W8Ssso29WVMkkVDQCeWkGqlSZZagcKkaRkDknWYjTw8d9OWnCjfrOX9brLfJlLCCuNuTME
	 Av5WRu+Ag+bVfgXq3o8jaFCTkcZ7TcVch++zWKZhgnnZKzrWpazGkGThnQTlyemqU8eNI1OKIiw4
	 CZZWNaimkRuVG5o/3Sz4Sgzt37tV8X8uyATJOYSixEbaA1FlxohB2Lq22qkQfZGrhX40rabLZC19
	 n936rApcqWOL6QFaXonsqsjXRTYvmMm/NfkOlD2iQP6bkqBBxUtwJu/FfVuUQm/ieNNfpi2RcXfJ
	 odgDPc6gvRatpccpKMaldT/T1HPR/DFWSMqCN4CykIQkBx5yqIwtv1u1Sef59+EkDK+bUw03N0EI
	 QKfWgkahxASKlYmkpiT7KNrXjHzFIIVCvNGB4C3ZCGAU7qAr5aNwwhlytfKzyvh60vV6OapEB3Iq
	 VYOdduPNMvuirQ5nvQZpQYbqgxEtbSxRlvZNnM6hcVkQhb8narcYu6zTO/7T/E5NSfZPQvstXlcu
	 m5lINn33MBG9VWVip8KzqJB8DlVhCSBZaEopPeru9byVvTcvLVQ5PgBz6Gox5k2DLFceXKxgL9Ke
	 gxUZJP+1oMPxTNRo7tLoNxv5b4IUlkxqIBmOX8Ux8KKZvmIuFjC98Mldkfxs9sZZFEgP6kTX4JYv
	 Pggc9tkzL9aBMEtlYJBoN/sKRQRickWt6NpYjMB3bFbynpT0LvK2wFHyOPnjw7AX8fmplOsNHEbs
	 sAAfgUEthxO7bSoF7G4SXVUMLbOsnmFsVg4WJmMpjCdaDAwY1fBCnxDuyCXJzVHrFEeq/qefZQ/2
	 JsDEJSSFv0DJPG9sZf5o5B5AvbW5ZAFTdPMpbWmo+OJzpUH/zgr1NlxwVTXPjSH3bliZPNTKWXbS
	 UGopzg2f1qlNhuKzg=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-OQ-MSGID: <3fce84da-5d35-4a8e-81fe-9b08ec4de7ec@qq.com>
Date: Sat, 13 Jun 2026 04:27:38 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/9p/usbg: Fix use-after-free in disable_usb9pfs()
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>, v9fs@lists.linux.dev
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 linux-kernel@vger.kernel.org, Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
 Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
 Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>,
 stable@vger.kernel.org
References: <20260607130118.16579-1-zhaoyz24@mails.tsinghua.edu.cn>
From: XIAO WU <xiaowu.417@qq.com>
In-Reply-To: <20260607130118.16579-1-zhaoyz24@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Yizhou,

On Sun, Jun 07, 2026 at 09:01:16PM +0800, Yizhou Zhao wrote:
 > disable_usb9pfs() frees the IN and OUT usb_request objects before it
 > disables the corresponding endpoints. If either request is still queued,
 > the later usb_ep_disable() call cancels the endpoint queue and the UDC
 > driver can still access the already freed request.

This patch correctly moves disable_ep() before usb_ep_free_request() to
prevent the use-after-free in the endpoint cancellation path.

However, while verifying this patch with KASAN and dummy_hcd, I found a
separate bug in the alloc_requests() error path that still leads to a
kernel panic in usb9pfs_clear_tx() during gadget unbind.

The root cause is that alloc_requests() frees in_req on failure but
does not set usb9pfs->in_req to NULL, leaving a dangling pointer.
Later, when the gadget is unbound via configfs, the call chain
reset_config() -> usb9pfs_clear_tx() dereferences the dangling
in_req->context and crashes:

   Oops: general protection fault, probably for non-canonical address
     0xdffffc0000000060: 0000 [#1] SMP KASAN NOPTI
   KASAN: null-ptr-deref in range [0x0000000000000300-0x0000000000000307]
   CPU: 0 UID: 0 PID: 10145 Comm: rm Not tainted 7.1.0-rc6 #1
   RIP: 0010:strcmp+0x5b/0xb0
   Call Trace:
    <TASK>
    look_up_lock_class+0x6b/0x130
    register_lock_class+0x2cb/0x540
    __lock_acquire+0xac/0x2730
    lock_acquire+0x1ae/0x360
    __wake_up+0x21/0x60
    p9_client_cb+0x59/0x80
    usb9pfs_clear_tx+0xe1/0x150      <-- dereferences dangling 
in_req->context
    reset_config+0xbe/0x2b0
    __composite_disconnect+0xb6/0x160
    configfs_composite_disconnect+0xed/0x130
    usb_gadget_disconnect_locked+0x214/0x500
    gadget_unbind_driver+0xe2/0x520
    ...
    configfs_unlink+0x3f6/0x840
    vfs_unlink+0x2f5/0xbd0
    Kernel panic - not syncing: Fatal exception

The reproducer:

   1. Create a USB gadget with the usb9pfs function
   2. Set buflen=0 so that alloc_ep_req() fails inside alloc_requests()
   3. Link the function and enable the UDC (enable_usb9pfs() fails)
   4. Unbind the gadget (configfs unlink or echo "" > UDC)

I wrote the following PoC to trigger this bug.  It creates a USB
gadget with a usb9pfs function, sets buflen=0 so that alloc_ep_req()
fails in alloc_requests(), which frees in_req without NULLing the
pointer, then unbinds the gadget to trigger usb9pfs_clear_tx() on the
dangling in_req.

---8<--- poc.c ---
/*
  * PoC: Dangling pointer dereference in usb9pfs_clear_tx()
  *      via alloc_requests() failure path.
  *
  * Patch: net/9p/usbg: Fix use-after-free in disable_usb9pfs()
  *
  * alloc_requests()'s fail_in path frees usb9pfs->in_req without
  * NULLing the pointer.  Later, when the gadget is unbound,
  * usb9pfs_clear_tx() dereferences the dangling pointer.
  *
  * Trigger:
  *   1. Create USB gadget with usb9pfs function
  *   2. Set buflen=0 so alloc_ep_req fails -> alloc_requests fails
  *      -> in_req freed, NOT NULLed (dangling pointer)
  *   3. Link function, enable UDC
  *   4. Disable UDC -> unbind -> usb9pfs_clear_tx -> CRASH
  *
  * Build:  gcc -Wall -O2 -o poc poc.c
  * Run:    ./poc   (root, KASAN-enabled kernel, dummy_hcd loaded)
  */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <stdarg.h>
#include <fcntl.h>

static int do_cmd(const char *fmt, ...)
{
     char cmd[1024];
     va_list ap;
     va_start(ap, fmt);
     vsnprintf(cmd, sizeof(cmd), fmt, ap);
     va_end(ap);
     return system(cmd);
}

int main(void)
{
     printf("=== USB9PFS Dangling Pointer PoC ===\n\n");

     system("rm -rf /sys/kernel/config/usb_gadget/g1 2>/dev/null");
     system("rmdir /sys/kernel/config/usb_gadget/g1 2>/dev/null");

     /* Create gadget */
     do_cmd("mkdir -p /sys/kernel/config/usb_gadget/g1/configs/c.1/"
            "strings/0x409");
     do_cmd("mkdir -p /sys/kernel/config/usb_gadget/g1/functions/"
            "usb9pfs.gg");
     do_cmd("mkdir -p /sys/kernel/config/usb_gadget/g1/strings/0x409");
     do_cmd("echo 0x1d6b > "
            "/sys/kernel/config/usb_gadget/g1/idVendor");
     do_cmd("echo 0x0104 > "
            "/sys/kernel/config/usb_gadget/g1/idProduct");
     do_cmd("echo 0x0200 > "
            "/sys/kernel/config/usb_gadget/g1/bcdUSB");
     do_cmd("echo 1234 > /sys/kernel/config/usb_gadget/g1/strings/"
            "0x409/serialnumber");
     do_cmd("echo test > /sys/kernel/config/usb_gadget/g1/strings/"
            "0x409/manufacturer");
     do_cmd("echo test > /sys/kernel/config/usb_gadget/g1/strings/"
            "0x409/product");
     do_cmd("echo Config1 > /sys/kernel/config/usb_gadget/g1/configs/"
            "c.1/strings/0x409/configuration");

     /* buflen=0 causes alloc_ep_req() -> alloc_requests() failure */
     printf("[*] Set buflen=0\n");
     do_cmd("echo 0 > /sys/kernel/config/usb_gadget/g1/functions/"
            "usb9pfs.gg/buflen");

     /* Link function */
     printf("[*] Link function\n");
     do_cmd("ln -s /sys/kernel/config/usb_gadget/g1/functions/"
            "usb9pfs.gg "
            "/sys/kernel/config/usb_gadget/g1/configs/c.1/");

     /* Enable: in_req freed but not NULLed */
     printf("[*] Enable UDC\n");
     do_cmd("echo dummy_udc.0 > "
            "/sys/kernel/config/usb_gadget/g1/UDC");
     sleep(1);

     /* Disable: triggers unbind -> usb9pfs_clear_tx -> KASAN */
     printf("[*] Disable UDC (expect KASAN report)\n");
     do_cmd("echo '' > /sys/kernel/config/usb_gadget/g1/UDC");
     sleep(1);

     printf("[*] Done. Check dmesg for KASAN null-ptr-deref.\n");
     return 0;
}
---8<---

Step 2 triggers the fail_in error path in alloc_requests():

   static int alloc_requests(struct f_usb9pfs *usb9pfs)
   {
       usb9pfs->in_req = usb_ep_alloc_request(usb9pfs->in_ep, GFP_KERNEL);
       ...
       usb9pfs->out_req = alloc_ep_req(usb9pfs->out_ep, usb9pfs->buflen);
       if (!usb9pfs->out_req)     // buflen=0 causes this to fail
           goto fail_in;
       ...
   fail_in:
       usb_ep_free_request(usb9pfs->in_ep, usb9pfs->in_req);
       // BUG: usb9pfs->in_req is NOT set to NULL here
   fail:
       return ret;
   }

usb9pfs->in_req now points to freed memory.  In step 4, the composite
framework calls usb9pfs_disable() -> usb9pfs_clear_tx(), which does:

   guard(spinlock_irqsave)(&usb9pfs->lock);
   req = usb9pfs->in_req->context;   // dangling pointer dereference

This is a regression from a3be076dc174 ("net/9p/usbg: Add new usb gadget
function transport").  The fix is to set usb9pfs->in_req = NULL after
freeing it in the error path:

   fail_in:
       usb_ep_free_request(usb9pfs->in_ep, usb9pfs->in_req);
+     usb9pfs->in_req = NULL;
   fail:
       return ret;

A prior review on Sashiko[1] also identified this issue and noted
several other problems in the same file (double-free in the
disable_usb9pfs() path after an alloc_requests failure, missing cleanup
in tx/rx completion error paths, and a potential deadlock in
p9_usbg_request).  The alloc_requests error path NULL fix is the
minimum fix needed for the crash reported here.

[1] 
https://sashiko.dev/#/patchset/20260607130118.16579-1-zhaoyz24%40mails.tsinghua.edu.cn


Hope this is helpful for further fix, thanks.


Best,

Xiao



