Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AB540D56B;
	Sun, 21 Jun 2026 01:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782007080; cv=none; b=jz3khXssyUuRVZGkaxzjd3EhT7LSpsVZL3pbG88JQXkB6pJI2EfsBmCRPuJ3U4F1+egoACWU4h1crIXS70CN2SyU1k/90ll/XSGZrQI4/w1s1poPfwyRd5/lLtCWBXNkLKX2PNcvKs/seW6cePgy4FziUtNpao0YZfc79TZnDbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782007080; c=relaxed/simple;
	bh=4nSA1W0dZ3A8My6Tx4FHMwMMhrp7udIJH9cyids71j8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oseg6mmp+2DbyEuNFT8w5vmZhUrJi/vWiZn1eDHavbdcWj1FTyNvjP/HtETupYqQ/usimiUmhie2N/U0n1ox0Hn3qp1kibV5FEkZZfXR4LhQ17xyOb8Wq/MrrZTpMNxphKy+SXoo5MSJixz+uJylHndrkTuZ3IwFUXMk+a4Dem0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=F9EdR5oI; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="F9EdR5oI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782007074; bh=55hwt14a22pOIRp3VuqOXwaLO6HclYYnZ2ZYgZoCtOw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=F9EdR5oI8bJI72ot0yFuwx3fdIQQ2pLRJj/eH19TLYHHm6wJLLZRkg3rBBA3ht9Xl
	 OBzBMg5LHUZUAjU3AGW/rUfb961re2PLGwGH5KP2n+/0aZNRyJlhYyUW0msjRde+gE
	 9xw19O5RFuINbDa5FoB86EuadYG3wo/Mdx6lSImI=
Received: from [192.168.1.100] ([58.19.27.181])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id E739C069; Sun, 21 Jun 2026 09:57:51 +0800
X-QQ-mid: xmsmtpt1782007071tzx1c1d63
Message-ID: <tencent_D72AF901D90EB103AEB5111845A7AC8FF705@qq.com>
X-QQ-XMAILINFO: OLixz+tJ9V4goIAVmWE1DjcDAN43z3Z1d+9P81Q4xCdfaVKB2CD+L9FA5ZhIqe
	 YuHJA8CV5CW2/XRv37jjjzN25nbM0thbWAFeBANWnHdC6zYcyAYlpZdoaajq+/qTy62JoBufgJ79
	 z6suv2DuhxJSdxwNOWQTqWJj79asYSSfEEkTsXjfd9V7kkAVVTF2LK6rhH6J0TbJXDhjnz5IRj0C
	 OK5uPV/0lbvWIH4dd19cZ/L4uCpWhylytOHN3DYjfYST/DQySvnqeUmPADsyo0GmLNO20IO7rcWi
	 I+c9GLTLJQ9PqtBRXiW3v2dywJDKjAYWCtbhkxaoBNs7HlVEj/bPjVlFSsXcXEj3hjCKCuDP4103
	 IRA7+FAGNMnYOli6knYOJWxzW1fCWJ6WuhTdlqlJtE/0jjsIyN4OIf8IR2EKtGgTGiUTQAcxkwil
	 BeU+WOC/f2DeIMYa7LNbUV1xsJlPjECttioL1XxKOHGlvaCAlQJQ0EBXHCsb6EWnlTabJF1jhdby
	 NUhPgzjAzevEL8QG/B38SSpkKCmBsnZ9T33BLkLSLpCv9NVO3cpsGEMsk231z0tYjQrd8UQASlXJ
	 Ay4MQ1/Jq9H8pJkxqPHq9s35LUoC9FVG+/n+5t+KpSCuLf0zAT3upQyVLtZjv8EXp1DgWSm4v4ys
	 t++W3tg3VnjhM+ckgyvdoRx9kfWBgFWujlWBAPtoZEeFVdqgQak8tuf3o2J9/pjgVZ19q4fSTfzS
	 SBRy9sOLeJkwH2+euotaiLWw79vywdcJ4wmtcy9vr6F2GmP3Z1csN4uUC65WxpCbQC/Ns9FAN9jw
	 vnHyUkD2ee1PpzK0wXYakhLuCgO+5oo1Qf6/Ge9meaWgbLAROrmBQFhSbkTTpgd/4duCSdB966i+
	 pfLa8yn3ibgBn2IMQJoBwXzDOVbXdbWSj4Xb08Bjqg54d0j1WGOOHy/oQ6tGTW22AvuBbeEoHm8t
	 VLaM1767njB/N1GnDGGnRdnGJ6JE6CWy0QSVPfpARPrxg3cMBxgn80QHv/R7UV8MTvEGbVNezHEE
	 2oYCVNrAN47OGm0IQxMZqoaqW8/ozh0L78g1WVFTNkHOb+SHSW4/E+ShsSfd81g/vDQ6oTJ5dqeg
	 a47VYrxjAvSYyS8Q/JPRzpzwRYAzeFvePhn7V2EvjClFBAhy0=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-OQ-MSGID: <e3ca8a21-44ab-4471-af23-0eecb9077d25@qq.com>
Date: Sun, 21 Jun 2026 09:57:51 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y] Bluetooth: hci_conn: fix potential UAF in
 set_cig_params_sync
To: Alva Lan <alvalan9@foxmail.com>, gregkh@linuxfoundation.org,
 sashal@kernel.org, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Pauli Virtanen <pav@iki.fi>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
References: <tencent_42D87A0C871AE6AF019BF6AB46F003577205@qq.com>
From: XIAO WU <xiaowu.417@qq.com>
In-Reply-To: <tencent_42D87A0C871AE6AF019BF6AB46F003577205@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I came across a Sashiko AI code review [1] that flagged a related
use-after-free in `get_l2cap_conn()` — it has the same lock-dropping
pattern that your patch fixes in `set_cig_params_sync()`.

I was able to trigger it in QEMU with KASAN on a 6.6.y kernel. Writing
to the 6lowpan debugfs control file races against connection teardown.

On Sun, Jun 8, 2026 at 5:56:55PM +0300, Pauli Virtanen wrote:
 > This commit adds hci_dev_lock() around the hci_conn lookup and field
 > accesses in set_cig_params_sync(). This prevents a potential
 > use-after-free if the connection is concurrently freed.

The same pattern in `get_l2cap_conn()` still drops the lock before
accessing the returned hcon pointer:

```c
// net/bluetooth/6lowpan.c: get_l2cap_conn()
hci_dev_lock(hdev);
hcon = hci_conn_hash_lookup_le(hdev, addr, le_addr_type);
hci_dev_unlock(hdev);                  // lock dropped
hci_dev_put(hdev);

if (!hcon)
     return -ENOENT;

*conn = (struct l2cap_conn *)hcon->l2cap_data;  // UAF if freed
```

The connection is returned without a reference count.  If a concurrent
disconnect event frees it via `hci_conn_del()`, the subsequent
dereference of `hcon->l2cap_data` hits freed memory.

[KASAN report — kernel 6.6.142, CONFIG_KASAN=y]

   ==================================================================
   BUG: KASAN: slab-use-after-free in get_l2cap_conn.constprop.0+0x73f/0x750
   Read of size 8 at addr ffff888106514ab8 by task poc/9349

   CPU: 1 PID: 9349 Comm: poc Not tainted 6.6.142-g1ab6d2b45d08 #1

   Call Trace:
    <TASK>
    dump_stack_lvl+0xd9/0x1b0
    print_report+0xce/0x630
    kasan_report+0xd4/0x110
    get_l2cap_conn.constprop.0+0x73f/0x750
    lowpan_control_write+0x574/0x740
    full_proxy_write+0x12f/0x1a0
    vfs_write+0x2ba/0xe60
    ksys_write+0x134/0x260
    do_syscall_64+0x39/0xc0
    entry_SYSCALL_64_after_hwframe+0x79/0xe3

   Allocated by task 56:
    __hci_conn_add+0x136/0x1ac0
    hci_conn_add_unset+0x72/0x100
    le_conn_complete_evt+0x667/0x2180
    hci_le_conn_complete_evt+0x241/0x370

   Freed by task 56:
    __kmem_cache_free+0xb6/0x2e0
    hci_conn_del+0x.../...

[1] 
https://sashiko.dev/#/patchset/tencent_42D87A0C871AE6AF019BF6AB46F003577205%40qq.com
     (Sashiko AI code review — "Use-After-Free", Severity: High)

Thanks,
XIAO


