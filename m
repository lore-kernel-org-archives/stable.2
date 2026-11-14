Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794618664;
	b=HGiSOF856SKh7IxNw0/WO7NEugcy9Nkeu6vE1oKFzAi+nrvV5aAshD0azjrZrMVfSLGA
	 /fUSmwHUX1U8bT7OYCUa+SzlkMb8Vgm8aWaW/+hL4ENIs5diDxJTPTcqNmamecLIrsnDc
	 F1L5Xp5LC3UVpWIf9AbwroepUe+V7GvXs6ZBycjoAoqD24twVd4HlONKAYno/XTuf8r5N
	 iZwIoHt0vWCtCOi3NOpqKoQ3LbXrae/KHDWDznr9JS51Kcuv4CkPt0K2Ys8mGQl4xPr7w
	 So38odW91Z5qbl3vzXpllxe0lcTZvV1iPRK22fkZ+gqhqgDt+3sWxLzFkoj+7mkvxfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794618664;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=O/VKPvGGlpUJ1LIySgVzYjcjmzvVQsovyAV6QPj6evc=;
	b=eyVKX3nZHiQ94Hew37M3VunYkC6XGznYD0h+BT+0Ak/krwlNGTP8/DwpIKs3e2Q8q3CX
	 eyBgq8Y2pDq8dBE5POXxWyTzCNBTgORJFZG3+CPI52mR5kqvYZ9ehtO2bhfrN2HOSy1j7
	 e7Jaxf4TxJO0nSCFAeGl5OlF+jhpZ0CiNrH+3cCAGo+SqW06WXOS4rn9QqGE9ZEZRpFZ8
	 Fn4mpFlYxnocp3jUYQPzVQfoqjHv1vXvY+AXivjoIXsd0x0v8rDK9ASCyEesvXlVlpww3
	 le7HEGvyd5PUN+0DFrEPU2wDYiRZX6kT/mYF1DcIggsgM5dNlgpy8tcRHe5hK9/Co0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0hujsDK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC0E606A323;
	Sat, 14 Nov 2026 01:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0hujsDK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C351F000C4;
	Sat, 14 Nov 2026 01:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794618664;
	bh=O/VKPvGGlpUJ1LIySgVzYjcjmzvVQsovyAV6QPj6evc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J0hujsDKWdpq3kQF/YebzkiDcsW6U4aCP7GwVntzsgtZbV3+VAewXKiMV5glgWUpe
	 fuljm8fNM7SwA1jcpZYR8tcWSQE70HUGZWxKZ5TT1ftGgv2zJ691HrGlVAXjecPL6p
	 4U5NzTDI/TEXAgACfTvR3RZujkrNcaigVamlojcCrmcnC8ToFwKmIHjfQHbA7bm2Nm
	 7G6xqD3iE5NzfrXd/N7zZmTdhIugkkqywsn6Gs8dWrbm7UiYDptrgSK0M7UJ9Lq32Q
	 ft/S5Fu5Xy5Wt7/A3m/WX7lIeluwCuCWizPu7RBBBvdMw4aYBlUaQEGT968YM2X8EA
	 X29ppDAY14Wyg==
Subject: Re: [PATCH net 1/3] e1000e: fix incorrect modified flag check in
 e1000_read_nvm_spt()
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 luoxuanqiang@kylinos.cn, tj@kernel.org, skunkolee@gmail.com,
 nsvatoslav515@gmail.com, stable@vger.kernel.org,
 aleksandr.loktionov@intel.com, alexander.nowlin@intel.com
Date: Sat, 14 Nov 2026 01:11:03 +0000
Message-ID: <179461866306.2199510.4595588811765356977@kernel.org>
In-Reply-To: <20261113005823.130021-2-anthony.l.nguyen@intel.com>
References: <20261113005823.130021-2-anthony.l.nguyen@intel.com>
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

- [Medium] The commit message overstates what the patch fixes.
- [Low] The second failure-mode bullet in the commit message is wrong.

--

e1000e: fix incorrect modified flag check in e1000_read_nvm_spt()

This patch changes the two-word branch of e1000_read_nvm_spt(). The high
word (data[i + 1]) is now taken from shadow RAM based on its own modified
flag, shadow_ram[offset + i + 1], instead of the low word's flag. The
commit message calls this a fix for silent NVM shadow RAM corruption on
SPT and later PCH parts.

> This can cause silent NVM shadow RAM corruption:
>  - if only the high word is marked modified, its pending write is
>    lost and the stale flash value is returned instead
>  - if only the low word is marked modified, the high word is
>    incorrectly overwritten with the low word's shadow value

[Severity: Low]
Is the second case described accurately? The pre-patch code was:

    if (dev_spec->shadow_ram[offset + i].modified)
        data[i + 1] =
            dev_spec->shadow_ram[offset + i + 1].value;

The assigned value comes from the high word's own entry
(offset + i + 1), not from the low word's entry.

Unmodified entries hold 0xFFFF. e1000_init_nvm_params_ich8lan() sets
them that way, and they are reset the same way after each commit:

    for (i = 0; i < nvm->word_size; i++) {
        dev_spec->shadow_ram[i].modified = false;
        dev_spec->shadow_ram[i].value = 0xFFFF;
    }

So when only the low word was modified, wouldn't the old code return
0xFFFF for the high word, not the low word's pending value?

> This function is used on all PCH chips from SPT onward (SPT, CNP,
> TGP, ADP, MTP, etc). The bug has been present since the dword-read
> optimization was introduced for these chips.
>
> Note: this was found via code review while investigating a separate
> reproducible packet loss issue on I219-LM (SPT+ PCH). Testing showed
> this fix does not resolve that particular symptom, but the flag
> check is still a genuine logic bug that can corrupt shadow RAM
> contents and should be fixed regardless.
>
> Fixes: 79849ebc0e06 ("e1000e: initial support for i219")

[Severity: Medium]
Can any in-tree caller reach the changed line on SPT+ parts?

The only way into e1000_read_nvm_spt() is hw->nvm.ops.read, through
e1000_read_nvm(). Every e1000_read_nvm() call in e1000e passes words=1,
except the one in e1000_get_eeprom():

    if (hw->nvm.type == e1000_nvm_eeprom_spi) {
        ret_val = e1000_read_nvm(hw, first_word,
                                 last_word - first_word + 1,
                                 eeprom_buff);
    } else {
        for (i = 0; i < last_word - first_word + 1; i++) {
            ret_val = e1000_read_nvm(hw, first_word + i, 1,
                                     &eeprom_buff[i]);

e1000_init_nvm_params_ich8lan() sets nvm->type = e1000_nvm_flash_sw for
every ICH/PCH/SPT+ part, so these parts never use the multi-word read.

With words=1, the loop in e1000_read_nvm_spt() runs once with i=0. It
takes the words - i == 1 branch, which already checks
shadow_ram[offset + i].modified correctly.

Also, e1000_read_nvm_spt() never writes shadow_ram. The only writers are
e1000_init_nvm_params_ich8lan(), e1000_write_nvm_ich8lan(), and the
resets after a commit. Even with a multi-word caller, wouldn't the worst
case be a wrong value returned to that caller, not corrupted shadow RAM?

The code change looks correct, but it fixes a latent bug. With the
Fixes: tag, stable will likely take it as an active data-integrity fix.

Could the commit message say that no in-tree path reaches the two-word
branch today? It could also drop the "silent NVM shadow RAM corruption"
and "can corrupt shadow RAM contents" wording.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113005823.130021-2-anthony.l.nguyen%40intel.com
