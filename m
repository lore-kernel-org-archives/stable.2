Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610341;
	b=O5zWHvzX+gMA5rgsVEIFnMaQY1wVCoSgSVViAdWOmRf+XD+o5g3p21tYswqN0qFqCN9E
	 hNXXWCqy87BIEICtW2kX27xD5f4+A1od8kH77eEuPcu5HN3PiKImd44/y7W7hW9VqRj+J
	 ssf1G7fE40+Hx2LKSN1jgQ1eFXLbFRwZQtHdp6s0z45rsqsgY1mc5XOZpeu/qW+uRTK/1
	 68C5f17IjiVP1kt8saO7Ou9t1HXsw1u3Zj/yFdX/ncpm6Joug8wJqhDNLHC1EMbWBYxO6
	 1ZiZCjka31XLcdG0lUypG8MUlp0hSq2mqhsA36mAWwlRGVaLkVsNX2ZHsXC5TyroMXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610341;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=8ksBKm+pzxuuq+S/3andYFYeVp/N1SmT8kmvLEwpdiM=;
	b=eaNDc41wg9fvYHzJa5ab5e98M6DIQJppfwiLU41NjEkn9ASsI6kLDxmr4olN5uCCJwV+
	 HjZVxuFPmyP4sqHZM7wJ4Yeh6S6FnLSaHieog/bbUdOtzX1FU7qCPDQ0NZCm6PBU4p87I
	 TEY4ss/vE0AhxMTw3dF68qTbO8fitCqhe78NIboZa+UnwzFuTv7bz4ioW7ovL9auvJFSj
	 64wOm2bHC73qFIXHwGHZ7gNn+g9WJ9NuiRvDnRd/JD8a+d4GGI1bayjlEVPic/6he74ME
	 9mWGVuBbTcBptAxYK1/u3OWas69J3ynOJ7pX+8dLpo8NPcMwMp1RqaWIBmmwAxiQlDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NOrbCY2W;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB01606A31E;
	Wed, 25 Nov 2026 12:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DB01606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NOrbCY2W
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D2F32F;
	Wed, 25 Nov 2026 04:38:57 -0800 (PST)
Received: from gaia.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F29D83F86C;
	Wed, 25 Nov 2026 04:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795610340; bh=cmw1itbte3IzHLZQjDwA+gCBb29y9QBqMepaxZQDr1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NOrbCY2WFx1gwZJX7Wx1i7fm4XXe2zPom8L5eAedmsmxMPBfiaBWikKdBGOk7bjHS
	 mHVKCa9/zp6coBzVCeCbxTt1If7iDivGxte3uh7DK+9cMls6f2Qv71tpRMJQ9jLZUW
	 oBbGSjYObKlRGV4l6GLPWtMDYoT/emhCsRY+ZCY8=
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org,
	Rui Qi <qirui.001@bytedance.com>
Cc: mark.rutland@arm.com,
	dylanbhatch@google.com,
	song@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	ardb@kernel.org
Subject: Re: [PATCH v3] arm64: module: Use text-poke for late PLT/veneer emission
Date: Wed, 25 Nov 2026 12:24:17 +0000
Message-ID: <179560945711.1480244.17746046705685189549.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261117113535.399407-1-qirui.001@bytedance.com>
References: <20261117113535.399407-1-qirui.001@bytedance.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 17 Nov 2026 19:35:35 +0800, Rui Qi wrote:
> module_emit_plt_entry() and module_emit_veneer_for_adrp() write PLT
> entries into the .plt section by direct assignment.  Once a module is
> fully formed its .plt is read-only/executable, so a late (livepatch)
> relocation that falls back to PLT emission -- an out-of-range
> R_AARCH64_CALL26/JUMP26, or an ADRP under CONFIG_ARM64_ERRATUM_843419
> -- triggers a synchronous Data Abort and panics.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: module: Use text-poke for late PLT/veneer emission
      https://git.kernel.org/arm64/c/a7e632493acf

I folded in a small fix which addresses Sashiko's comment: the bounds
check before the write must allow i == plt_max_entries since .plt has
plt_max_entries + 1 slots (the last one is where a duplicate of the
final entry is built before being discarded). I restored the
plt_num_entries check after the duplicate test as well.

I moved the module_write_place() prototype to asm/module.h, next
to the other PLT emitters. I concluded it's a better fit than
text-patching.h. My concern on v2 was the macro but now it's an
out-of-line function. I also dropped the const from the val argument,
which removes the (void *) cast when calling aarch64_insn_copy(). All
callers pass non-const locals anyway. It would be a good cleanup in the
future but that should also add const to aarch64_insn_copy().

Please check that I got these right.

Sashiko had some comments on v2 which we concluded are existing
problems, just exposed because we no longer take a fault. If you have
time for a livepatch reload follow-up (probably not cc stable), there
are two separate problems when the target module is unloaded and loaded
again:

- The livepatch module's .plt slots are reserved once but used again on
  every klp_module_coming(), so a reload eventually hits the WARN and
  the target module is rejected. This is safe but we need some slot
  rewinding or a clear_relocate_add().

- With the A53 erratum 843419 workaround, if the first application
  replaced an ADRP with a B to a veneer, reloc_insn_adrp() reads the
  B back on reload as if it were an ADRP. It either encodes the ADR
  immediate into the B or decodes Rd from the branch offset. This
  corrupts the livepatch code silently on the first reload (unrelated to
  how many slots are left). Not sure yet how to fix this, maybe the
  original instruction needs restoring on unload (or saving).

Thanks.

-- 
Catalin
