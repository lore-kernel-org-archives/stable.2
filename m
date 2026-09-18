Received: from mta0.migadu.com (out-110.mta0.migadu.com [91.218.175.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE186305677
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 07:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789716177; cv=none; b=svPF+Mr/vnHIQiv7spRqcr/Rh6NXjr5lBSJP8qDRC2LUb2+I9cj4xy+3Azl2FCtvl7jlAupvL6UfMNFxvtlaowDiDx52Cl6xqiMWuyNuXn1rAK8XcO69bBRz2+TJ9ulhbJnG7b5jXBOyoWwg3YGOuBtxBweUvHTDmFuFtwUL1R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789716177; c=relaxed/simple;
	bh=dNme8uRIYN0dXbX3fo0hsH8S0MXXz3OARTVkTdVwCds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TceboXwogXY42kGcROgNpbMzRS19Iej6+PKjBj2Ww/x9N931IVbn0guX2IQUewcwOAjaROh3s9vgrKzh+YA/vJrnCGW2wMlIHuSVgqrdAwESAjSvE4sVBkIHdIPOudtjkqd72krss7QIBsJPPADxlN3KglTf8CJrocLWNAsCCnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=azSJLlBY; arc=none smtp.client-ip=91.218.175.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="azSJLlBY"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dNme8uRIYN0dXbX3fo0hsH8S0MXXz3OARTVkTdVwCds=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789716173; v=1; x=1790320973;
 b=azSJLlBY+Ud7Zbrksgh3OGEzgNVPYu6TeLzMhPkuGRywPEpjiJqKNu48dEQr1B6lprapAMIG
 unhqKIj9quN5X52808jZjCSV2J77mDO3Dh7kHj5N6e8tWO479HKw1esg4G/92/7wqVg2Cjke/0Q
 M1uQZZcm0x0yWe6VV3kzPnhU=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 067db40a20321829;
	Fri, 18 Sep 2026 07:22:53 +0000
X-Mizu-Trace-ID: 067db40a20321829
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b83c1421ecso4634e87.1
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 00:22:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwhN7pvxG1aKoKdDRu+LhNy0COrOXkbxHQTRE6nm0bOPPdqx6SARy6Idtjfz9GWC+sFllWpfz0=@vger.kernel.org
X-Gm-Message-State: AFuF++kuuJCd5VM2wDT6U4Lm3O5dT160R5h9bhy+jEr79ma2ZALmy+TA
	FhrBV6Zj1JhY3FmEgwRx+ZzHRwdToiXiwq9xK/Nwyk7Qe5CDUVXy8mF8m75QfEWtX6doDdz8Prq
	bieP8ZWh+20etYFM7NfpDyHWdrlIgzjhyO+KamccB
X-Received: by 2002:a05:6512:2344:b0:5b1:ca0b:25d2 with SMTP id
 2adb3069b0e04-5b8c101ffcdmr104708e87.4.1789716168414; Fri, 18 Sep 2026
 00:22:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918040214.85580-1-ndaugoing@gmail.com> <20260918040214.85580-2-ndaugoing@gmail.com>
In-Reply-To: <20260918040214.85580-2-ndaugoing@gmail.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Fri, 18 Sep 2026 08:22:12 +0100
X-Gmail-Original-Message-ID: <CA+EHjTx8zzvgqj99TKWfRD58X-M8v+hs9358_r_1zZonFNEsgw@mail.gmail.com>
X-Gm-Features: AcwNN1VwD5DsYs2cjOJY92QTdxd3reBSIUtzU8JUmsF3mGfW8sf3G3EvUGgiBaw
Message-ID: <CA+EHjTx8zzvgqj99TKWfRD58X-M8v+hs9358_r_1zZonFNEsgw@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: arm64: vgic: Do not remove in-flight LPIs from AP
 list on disable
To: zjamg <ndaugoing@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Yuchao,

On Fri, 18 Sep 2026 12:02:14 +0800, Yuchao Zhang <ndaugoing@gmail.com> wrote:

[...]

> Note: this closes the primary race (the last_lr_irq node itself is no
> longer unlinkable while in-flight), but the fold traversal can still
> race with a remote flush unlinking a subsequent non-LR node in the
> ap_list tail. Fully closing that window needs the fold side to take
> references before dropping locks (in the spirit of the prune-side fix
> in commit 7258770e5814 ("KVM: arm64: vgic: Handle race between
> interrupt affinity change and LPI disabling")) and is left as a
> follow-up.

This is the same race Hyunwoo reported back in June [1]. You might
want to have a look at that thread first: Oliver and Marc's view there
was that the fix is to take the ap_list_lock in
vgic_v3_fold_lr_state() [2][3], and Hyunwoo posted a draft of that
[4].

Cheers,
/fuad

[1] https://lore.kernel.org/r/aiHrGM1f8czcUby4@v4bel
[2] https://lore.kernel.org/r/aiJi5a3JJ-TbWL-s@kernel.org
[3] https://lore.kernel.org/r/87a4t99z9n.wl-maz@kernel.org
[4] https://lore.kernel.org/r/aiXvwGD1hS6vwLEd@v4bel
