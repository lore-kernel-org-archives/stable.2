Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795747309;
	b=UmOMK7j1OZg4W1Mz4Xlwyenx2JaSyexQCDceiJeZ0YGzS5HbtSnQHA43NfyeXvCTIF+n
	 PLsALQWTVoBBmIFC/epZkfRIxFz+mTW66uDLtKjIoax/H2AsRoeDio8veCli86nRVea48
	 B23mzSCUsVvgqPjw4p/Sf2TS4SRvrF36ZB9DsHG7K1xDrDmVecPIoDIlLN2YoYI6vkKzM
	 jL0QWMhKg0LvoqdUn5WdCwtMsRUFWOIVgmny4l//sJYovbUuNczsZDS3dafGQYY7G3Iar
	 9nkVbD4v9S3WupXVlCn8RPLyz2PSuegTQdK+UVGLL0gWTRlVw+fVkD7ZI+hTa3Ts+bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795747309;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=VAR2rz8eXDLkPjCKjfmnvh48//s9d1yIgXhNth07Doc=;
	b=vcdtmrobslrD114mM0wB0/o/sAuj9jA7tpAaluqtQrI/yGyz4ixoQTbCuwxjLqfDSGM7
	 7V8YoGRK2eJGnUOAUlCNg7X4qaZYsfigTGVvHOlaBk9KhHvzOqFPAMdWL3fe6z+f6SMuX
	 vIq4Z9E9fBYKA+NGO01ciNUkqXASzfHB5jeclevGBc/IYyweASMRTgEW8l/Kgu+QEXIq4
	 0QpSJ+u8K2GOAKXu6JXP8lQWixwxr8KHu2Z7Jiwd0u1BQ/Lta+TBeQ7lbMVTHC4yLpDM6
	 kSgLFMJzXv/XjdCQo03Fp9AA7+92Y5796g94jVGYvW/7XAH+uBbC5PglAJCZ/w7utZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0fyoVmX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A6E606A31E;
	Fri, 27 Nov 2026 02:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0fyoVmX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE131F000C1;
	Fri, 27 Nov 2026 02:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795747308;
	bh=VAR2rz8eXDLkPjCKjfmnvh48//s9d1yIgXhNth07Doc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c0fyoVmXK60ROx38e7J/XKeMSPpRHy+ayOjW/uc+Rzp0silZ0W0jW/ycmbFx9DRSu
	 RpCFRNZ0hKJkVSaqnTJJboOnqQRUrCHa1n3pNkYN/HBUJf2RkeOTOcKuyoIzY4fFJn
	 FXKUN33u8uUXeSiGe8Od+RRHCH58DCWtpP7wWmHy8L7zV1zAHfwqNc1oVrXp0RQMxL
	 xSzkSTCsMZZB7QYZs7DbAczm9y5qUc6iKBJCye2u2l/CW564qmPIFs2wjPEIw4v/Nw
	 YC6cvMosL/kOgoP/f8XTIIBq85UvDT+O6/iN03xh0S87ytisuJJtlsj0btHqh//yuR
	 Ob9aktQN50ipg==
Subject:
 Re: [PATCH v2] net: ethtool: do not call get_regs() for zero-length dumps
From: netdev-bot+sashiko@kernel.org
To: 25031212351@stu.xidian.edu.cn
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, horms@kernel.org, byu@xidian.edu.cn,
 wencheng@xidian.edu.cn
Date: Fri, 27 Nov 2026 02:41:47 +0000
Message-ID: <179574730769.3135.6060942775562840087@kernel.org>
In-Reply-To: <20261126015239.6038-1-25031212351@stu.xidian.edu.cn>
References: <20261126015239.6038-1-25031212351@stu.xidian.edu.cn>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In ethtool_get_regs() (net/ethtool/ioctl.c), the new `if
  (!regs.len) return 0;` check runs before `ops->get_regs_len()` and its…
- [Low] In ethtool_get_regs() (net/ethtool/ioctl.c), ETHTOOL_GREGS with
  regs.len == 0 now returns success without calling ops->get_regs() and…

--

net: ethtool: do not call get_regs() for zero-length dumps

This patch adds an early return to ethtool_get_regs() when the
user-supplied regs.len is zero, so the driver's get_regs() is no longer
called for a zero-length dump. The goal is to stop drivers such as mcs7830
from issuing zero-length USB control transfers on the receive pipe. Those
transfers trip a WARN in usb_submit_urb().

> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 80b7930b3fe0d..e8af861ee5de3 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -1779,6 +1779,10 @@ static int ethtool_get_regs(struct net_device *dev, char __user *useraddr)
>  	if (copy_from_user(&regs, useraddr, sizeof(regs)))
>  		return -EFAULT;
>  
> +	/* A zero-length dump has nothing to fill in. */
> +	if (!regs.len)
> +		return 0;
> +
>  	reglen = ops->get_regs_len(dev);
>  	if (reglen <= 0)
>  		return reglen;

[Severity: Medium]
Can this early return hide errors from get_regs_len()?

The new check runs before ops->get_regs_len(). So when regs.len is 0, a
negative return such as -EOPNOTSUPP is never passed back. The ioctl
reports success and copies nothing back.

A GREGS request with len == 0 is what a normal ethtool -d sends when
get_regs_len() fails. That happens because ethtool_get_drvinfo() only sets
regdump_len for positive values:

net/ethtool/ioctl.c:ethtool_get_drvinfo() {
    ...
	if (ops->get_regs_len) {
		int ret = ops->get_regs_len(dev);

		if (ret > 0)
			rsp->info.regdump_len = ret;
	}
    ...
}

Userspace then sees regdump_len == 0 and sends ETHTOOL_GREGS with
regs.len == 0.

There are two in-tree examples. DSA user ports always install
dsa_user_get_regs(), so the !ops->get_regs check does not catch them, but:

net/dsa/user.c:dsa_user_get_regs_len() {
    ...
	if (ds->ops->get_regs_len)
		return ds->ops->get_regs_len(ds, dp->index);

	return -EOPNOTSUPP;
}

And hns3:

drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c:hns3_get_regs_len() {
    ...
	if (!h->ae_algo->ops->get_regs_len)
		return -EOPNOTSUPP;

	return h->ae_algo->ops->get_regs_len(h);
}

Before this patch, ethtool -d on these devices printed an error such as
"Cannot get register dump: Operation not supported". With this patch,
ethtool -d appears to succeed with an empty dump.

In the standard ethtool flow, this seems to undo the error reporting that
commit f9fc54d313fa ("ethtool: check the return value of get_regs_len")
added for hns3. The commit message does not mention this.

Would moving the zero-length check after the "if (reglen <= 0) return
reglen;" check keep the error codes? It would still avoid calling
get_regs() with len == 0.

[Severity: Low]
For drivers whose get_regs_len() returns a positive value, does this
change what a len == 0 query returns in regs.version?

Before this patch, such a request skipped the clamp and set reglen to 0.
It then called ops->get_regs() and copied the ethtool_regs header back.
For example, mcs7830 fills in the version:

drivers/net/usb/mcs7830.c:mcs7830_get_regs() {
    ...
	regs->version = mcs7830_get_rev(dev);
	mcs7830_get_reg(dev, 0, regs->len, data);
}

Now the ioctl returns success without calling get_regs() and without
copying the header back. regs.version keeps whatever userspace passed in.

The uAPI kernel-doc for struct ethtool_regs in
include/uapi/linux/ethtool.h still describes @version as driver-specific
output.

Stock ethtool sends len = regdump_len, so it is not affected. This only
affects callers that send len == 0 to read the version alone.

The commit message says:

    A zero-length dump cannot return any data, so there is nothing for the
    driver to do.

and:

    Zero-length register dumps used to be issued so that drivers which only
    report a revision ID could fill regs->version.  Those drivers return
    zero from get_regs_len(), and the core has returned early for them
    since commit f9fc54d313fa ("ethtool: check the return value of
    get_regs_len").

That covers the case where get_regs_len() returns 0. It does not cover
the reglen > 0 case that this patch changes.

Should the commit message or the uAPI documentation describe this change?
Alternatively, should a len == 0 request fail instead of reporting success
with the header left unfilled?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126015239.6038-1-25031212351%40stu.xidian.edu.cn
