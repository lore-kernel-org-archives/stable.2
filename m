Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428848;
	b=RP/udpmCiF979vr5NdOXTXStEWMmTgeC6LruhvAE5WpRxjVCKgtTChhEm+Tu25jVY6AD
	 mV35AY+wqXcbgK2QFLdT41GTCLQF9iSZncG/4ctCQV8cCAk+mOEy8ryGEyGV1y57okabv
	 yF9TNQi3SuYTJO8VEvFanpQicYeI6x4bFLsGQWcSwgGaxuHDMtaJFXPjawY2b4eSjchvr
	 bZtUzouiP4rxNfoMUldZaxof7Tmper8w8EkhfAGrHsZPxCAmakGta/JAyEaHJ8VXYCL2S
	 AHvNUUMx+BSzeAlu2xXv955vgG/tIaAnZpeVpsPyrCKVGuty7grlkJ7URtePxQrdjow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428848;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=g+hlyuXTXCIxB36zR/n3kH2plCVxKzMUEqxRKYhxisk=;
	b=ff9dpWW+mNE77EAgcWczdUX+V9TIydi4r+1HtnurlaDvyLKvMCAJUOpoG4gaYEWFwfKL
	 rYZb5iH1lOGHXrviKuBBi+O/VAizmGG+KecWulnI/YV7ETYdWlZIZMkd8SSYX0dk6wZ9V
	 M1a854ZaoGqNG2B9eSxKTUttHORQ8NTqiuPXFlOjfxT8O6hUkkrzVWdy4DJ5TPxeHnpkA
	 5b/tnTMRV47HQxwpyFrYN0iby46yni0UmTAScVAj47ohpMaHYcXzh+rF82We58tDhlfGU
	 S007nKVcQgbT2zeFUiJt/1hapReXYMOkn6hzdgCpXrXz0ptR0XeDqTQQGJZWYR/TryQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U4f18klA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3813F606A330;
	Wed, 11 Nov 2026 20:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U4f18klA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD961F00A05;
	Wed, 11 Nov 2026 20:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428847;
	bh=g+hlyuXTXCIxB36zR/n3kH2plCVxKzMUEqxRKYhxisk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U4f18klAluHIX1bmSD6lEPTg6vG33IcCHoGhX6EZvcUEqxSPMZp/CBRoKyLw+C/Hy
	 VQZv7WUpY4qnzO98DJ2vo82dkDOyhmnedx1WV6CmhlBwn3oX1xGQHu2Gp3zmIuBAQR
	 ElTC4UzRZGvBs3bSCDrRbWNrvdR7wqmdQZ7xaEoEKS4ukYGhKqM8ObzKVx1mPvtAI+
	 A92sgoToXys2D4xv0lLl0MjarGgKBhMYjWhweQOTw0yYaASRMr6UcqJh0oir/A+AGL
	 cH93oo11QU4OHOu9yqMF0Vy9nJcdeEz9PlI1RBgzxA4sKznXvblMjAv5XFON/Zojng
	 aqSCH3vmCKL0A==
Subject: Re: [PATCH 1/2] can: kvaser_usb: hydra: reject commands shorter than
 the header
From: netdev-bot+sashiko@kernel.org
To: joasantonio108@gmail.com
Cc: mkl@pengutronix.de, mailhol@kernel.org, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Date: Wed, 11 Nov 2026 20:27:26 +0000
Message-ID: <179442884694.488853.1203340184494622977@kernel.org>
In-Reply-To: <20261110-kvaser-usb-validate-v1-1-f266b85aa908@gmail.com>
References: <20261110-kvaser-usb-validate-v1-1-f266b85aa908@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch says it rejects commands shorter than the header.

--

can: kvaser_usb: hydra: reject commands shorter than the header

This commit adds a lower bound on the command length returned by
kvaser_usb_hydra_cmd_size(). The check is added in both
kvaser_usb_hydra_wait_cmd() and kvaser_usb_hydra_read_bulk_callback(), so
a CMD_EXTENDED command with a zero length no longer causes an infinite
parse loop. Lengths shorter than struct kvaser_cmd_header are now treated
as format errors.

> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> index 687911d764ded..92bfdcb04b019 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> @@ -676,7 +676,8 @@ static int kvaser_usb_hydra_wait_cmd(const struct kvaser_usb *dev, u8 cmd_no,
>  
>  			tmp_cmd = buf + pos;
>  			cmd_len = kvaser_usb_hydra_cmd_size(tmp_cmd);
> -			if (pos + cmd_len > actual_len) {
> +			if (cmd_len < sizeof(struct kvaser_cmd_header) ||
> +			    pos + cmd_len > actual_len) {
>  				dev_err_ratelimited(&dev->intf->dev,
>  						    "Format error\n");
>  				break;
> @@ -2156,6 +2157,11 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
>  
>  		cmd_len = kvaser_usb_hydra_cmd_size(cmd);
>  
> +		if (cmd_len < sizeof(struct kvaser_cmd_header)) {
> +			dev_err(&dev->intf->dev, "Format error\n");
> +			return;
> +		}
> +

[Severity: Medium]
Is struct kvaser_cmd_header the right lower bound here?

kvaser_usb_hydra_cmd_size() returns sizeof(struct kvaser_cmd), which is
32, for every non-extended command. So this check only has an effect for
CMD_EXTENDED.

The fixed header of an extended command is the 8-byte prefix of struct
kvaser_cmd_ext, and the length field is part of that prefix:

struct kvaser_cmd_ext {
	struct kvaser_cmd_header header;
	__le16 len;
	u8 cmd_no_ext;
	u8 reserved;
	...

With a 4-byte bound, a CMD_EXTENDED with len between 4 and 7 still passes
this check, and also the new check in kvaser_usb_hydra_wait_cmd(). In the
bulk callback the command is then handled like this:

kvaser_usb_hydra_read_bulk_callback()
  kvaser_usb_hydra_handle_cmd()
    kvaser_usb_hydra_handle_cmd_ext()
      switch (cmd->cmd_no_ext)
      kvaser_usb_hydra_rx_msg_ext()
        memcpy(cf->data, cmd->rx_can.kcan_payload, cf->len);

Both cmd_no_ext (offset 6) and rx_can (from offset 8) are outside the
declared command. So the dispatch decision and the CAN frame passed to
netif_rx() come from the next command in the transfer, or from stale URB
buffer bytes. Parsing then resumes 4 to 7 bytes later, in the middle of
what was just treated as payload.

The commit message says "A command can never be shorter than its header".
The leaf fix it cites, 0c73772cd2b8, bounds by CMD_HEADER_LEN, and that
header includes the length field.

Should the CMD_EXTENDED minimum be at least
offsetof(struct kvaser_cmd_ext, rx_can)? For reference,
kvaser_usb_hydra_frame_to_cmd_ext() always builds extended commands of at
least 32 bytes, aligned to 8.

A complete fix would also need per-sub-command minimum sizes, similar to
kvaser_usb_leaf_verify_size(). The extended handlers already read up to 96
bytes based on dlc, whatever cmd_len says. That over-read predates this
patch, and neither bound fixes it.

The later patch in this series, "can: kvaser_usb: reject devices reporting
zero max outstanding tx", only changes probe in kvaser_usb_core.c and does
not touch these parsers.

>  		if (pos + cmd_len > len) {
>  			/* We got first part of a command */
>  			int leftover_bytes;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110-kvaser-usb-validate-v1-0-f266b85aa908%40gmail.com
