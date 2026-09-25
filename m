Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBA020E023
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790301631; cv=none; b=NwIlrYqxwhc9EHmpviQ1Vtgk4yzuVIvKxRfRLg6sJIEt/0e67pPgUNyO1SiAiXiVMOgHQA5SEkyzl++P+Aa0rxxC0jTfRifgu4JBq8i5HoNB606Ovui8ZG1taNoet3akcZAAKAoPwValY8qiEuvi6peB2y8PiP/u1z+xDnIZp9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790301631; c=relaxed/simple;
	bh=B+MQDJkbz2ZurZea5vqo3nhLCU5cbS/MTcfN28h2I6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hQdYaGDfHw/2Xl1jvsf88xOzkGsK+TnNCmPEcjFLKuiHKK5yH+Gsfa4D8kU1rNIPeGm3o+Zrg2VI7M4bXfG8PNr1Fp29vgeHVrop49ln+gTyo85GOe4ZphW0oMjk7+YRiIWLMW+1RfDRmlrqAqdmptcvPg2yT1Z5JR6onUPmJFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfyZPT/x; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfyZPT/x"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-3a0a97efe99so28512a91.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 19:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790301630; x=1790906430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wdXQvAxDw9Kg7I9/XYmAKp3RYy+BwvAtZIh1L7zo0oo=;
        b=TfyZPT/xFN1HR3Z5zKavfCc/upNJIEs3sGNuTPXQBh9B5bb4Pn8Y1eC43JWwB7SRAS
         U+eH6/EhwxeIiut5WMN1XfxkhYa9bB0E4/p0zvLofsO/SxwpXASh4N90Jzd+3d2WdCxh
         9/953vlZYTS3mqKDFfjfCqaCTuv6KK//+Nd/9bVKo30T1GZ4RW2DdYgJOlJCVomQPT35
         99g+TuLiixef/eYUAg2I+jBDhPwqiHQV0YVLxvto0Dedo5x0Uc4raGlyAI7B2zKltrWw
         oXQ+iMNeQkFItH21L6LC7unUP1aAXvwwjT0c+fqCHoFlyqObJtXtm3LWxRUYSr+ijuh8
         vYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790301630; x=1790906430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wdXQvAxDw9Kg7I9/XYmAKp3RYy+BwvAtZIh1L7zo0oo=;
        b=L0oYJhz4CuMaWJQINnbt4c0LBmE4vs78Zcoldoz0GHxlGvEiPl6yypWsv7duwj34Qp
         UnIGGi1hx7r2YPNmkniJsimfkj9Bs1yQSOgbaWdAvdSbOggL0G1oi+2MVm6ebVJBQE7w
         DFXC+LQNRqkTrkORyL7CGHnUvl9OhvAicyKq+F2yWqO7ygiOrU2PObSpWipzuVrxZy8G
         qX0jfQCRwgNe+eWJ+ktq2QZG+yOVsalR01oSbvvFGmkj2KvxVjhqNeA/A8QI0hwGXgL5
         o3Idxo/aaax5k/00YbLORJkQaofzIRJ++8Yed2vIgNxYzcpXnbs4G0ZuMmtEDB+idEYx
         qxAA==
X-Gm-Message-State: AFuF++leKglCr6KH+VZpNhFz0rAmb5Oz31CIqkqZF+geSHHv/tVdzF+s
	M1YRJfdD3VOLXHodJOBu3iAducyLaE8SX81Rp++DqCZztyWv9ZkxUIbq81muvpwsUzk=
X-Gm-Gg: AYBFou0F10w9azbPMfi7Hm4kQpQT/Shx6q6v6IJCz62YRS1qbDsAioEfH9JZ/QslxDo
	Jyz9dej2eOs+RcjnnH3WXJiwZ4+vudg1rfxORKC6dtockI9dvsekVuDg10y/Lisp69k+PPYM9Rx
	9KfJtNt5hS/Fr5AOjRLXJtRfqdeEDQLuFS5RjODibcCaoYpzSYh4CMEvxa+ZE4kw5U89v0sG1HX
	it0Qtq6vJuWxL4XLitRFjur2ERrGMFbcuG6yDZT4A3ttHWc5j+ar1UUOAIAibW+KJAfcr3N7N6Q
	PSa+iQiWxebMxtYf2EaM/27igBfVWghe9vR7DYi9SE2gNFb5Zo89eZSSMncO1++BPdWDCLDAWDa
	RQbNTqXJSfaokP1aSntxM+/ww/0vXaI4A+4GzeSxMqprSCoGOscnoKtKcKU1SdTP9YVj3h5C9Ps
	HEF04A3mYErDN4GcYguPdivrMiA+AGoK4MSvVTiZrWNu0oQI8L1JFYPxd5yxH0jz+2HtJmRPACB
	pUOCeZQ92M=
X-Received: by 2002:a17:90b:3889:b0:39e:55ce:af15 with SMTP id 98e67ed59e1d1-3a0b28344abmr2168977a91.5.1790301629463;
        Thu, 24 Sep 2026 19:00:29 -0700 (PDT)
Received: from localhost.localdomain ([175.159.181.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0ba31f408sm369914a91.3.2026.09.24.19.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 19:00:28 -0700 (PDT)
From: Yu Junzhe <junzheyu1@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org
Subject: [PATCH request stable 6.12 6.6 6.1] netfilter: nf_tables_netdev_event UAF of binding chain
Date: Fri, 25 Sep 2026 02:00:25 +0000
Message-ID: <20260925020025.616-1-junzheyu1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Please consider a backport of the following use-after-free to the
longterm trees that still have it: 6.12, 6.6, and 6.1. 6.18 and newer
are not affected.

There is no single upstream commit to cherry-pick. On current linux.git
the netdev notifier no longer calls __nft_release_basechain(); it only
unregisters the per-device hook. That change arrived as part of the
netdev-hook rework and does not apply to these stable trees.

Bug
===

nf_tables_netdev_event() walks table->chains with
list_for_each_entry_safe. On NETDEV_UNREGISTER of the last hook,
nft_netdev_event() calls __nft_release_basechain(). Releasing the base
chain deactivates a JUMP to an NFT_CHAIN_BINDING chain, which
nft_chain_del()s that successor and nft_immediate_destroy() kfree()s
it. The walker's saved nr still points at the freed nft_chain.

Still present in:

  linux-6.12.y  (6.12.111)  nft_chain_filter.c: __nft_release_basechain()
  linux-6.6.y   (6.6.157)
  linux-6.1.y   (6.1.188)

Gone in linux-6.18.y and linux-7.0.y.

Reproducer (nftables 1.0.9)
===========================

An anonymous jump is what sets NFT_CHAIN_BINDING (chain flags 0x4).
Commit the base chain first, then add the jump in a second command.
Chains are appended to table->chains, and the walker frees the chain
that follows the base chain. One nft -f that contains both creates the
binding chain first and does not hit this path.

  ip link add br0 type bridge
  ip link set br0 up
  nft -f - <<'EOF'
  table netdev t {
          chain in {
                  type filter hook ingress device "br0" priority 0; policy accept;
          }
  }
  EOF
  nft add rule netdev t in 'jump { accept; }'
  ip link del br0

The namespace must still be alive. Netns teardown is too late: nft
pernet exit wins that race. Needs CAP_NET_ADMIN. Do not run on a host
kernel.

Confirmed on Linux 6.6.144 KASAN (same __nft_release_basechain() walk
as 6.6.y and 6.12.y). I have not booted 6.12.111 or 6.1.188.

  BUG: KASAN: slab-use-after-free in nf_tables_netdev_event+0x635/0x970
  Read of size 8 at addr ff110000037faa20 by task ip/229
  Freed by task 229:
    nft_immediate_destroy
    __nft_release_basechain_now
    __nft_release_basechain
    nf_tables_netdev_event

The read is 8 bytes at offset 32 of a kmalloc-128 object
(nft_chain.list).

Thanks,
Yu Junzhe
FuzzAnything <fuzzanything@gmail.com>
