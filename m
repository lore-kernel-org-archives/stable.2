Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FC14D2ED5
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789732265; cv=pass; b=oRlW/oTmj9UQSrG/dxiXNrvphat2q+EJtCjfO8Ml5HIuikspr9rFyrw39x7mYBvJ6NieS98qWOAxazeKccSJ1ZJzNkxNBKxthPHbaYYqFAOQobh5YYd5iWQk7nO+ppZsVibHrlCYg8F9k55RdSopJdoBCs6Mzo+iGBzRoyjVHIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789732265; c=relaxed/simple;
	bh=HR32eDowvoU7s9fv7SYXh2McaBai5hrd98uYm+h1guU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EbD7UHuFbk3QJsi0LGAfxqc/cqk9EF2NcE7iYI2sWcgja14pc9lvs79CQSFwo0/d0Fjaee8QVEvuLWdUVl8ZFLKadRrd34HjJPcMbiX6fRfUnNj2hxtKmmZPGTNhfwJqyFBkMQOZXyPuDCFouzlhRcw39fKaNOsLCVXCzNA2xc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPHw0cBN; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPHw0cBN"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c254f55efe7so93200466b.3
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 04:51:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789732262; cv=none;
        d=google.com; s=arc-20260327;
        b=ixKXW/GSmDw/buoNJT6Q/u9SRErbsOPB5GWMS5jrZmslLDEjRW0MHPHClxmfc9EMvv
         kUSJ3KFV4qtKvwGMnE0mQIiTZkm9DP8EYC8qkx34t8mHu4sfj/cGiWAX3RVMtocpk9uJ
         QqGqGMiqpDH9i1yRK0Y6VucyJ3k5tug6zFXivPjszaAi3jxtPOxWQVgCnX3KwI5ZWnGH
         SsGBhBrYh7zcVzP57MgTkosN4c+n8lCtHo9noPsRHz4i7uhLK+C7IxbSE6q45R0bovGQ
         /zmmLxf/7aKR37OJVwRVpHNHfzBc6Q3Z477hZQDFA5dHOGJmmE8uoTgav61mBkpAEJRP
         VKGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HR32eDowvoU7s9fv7SYXh2McaBai5hrd98uYm+h1guU=;
        fh=FfyTc3l/Evp8NTEay7Y8bVNEYQrZPFUhOr/dAOLjaMc=;
        b=LoEEOnnvr+7oRIBQxZL9QJal+/0KHQ3KOJ9TCCGwE5FVVCHtAQiW2x8TQUFpTsbaU8
         Ezy8vxqVUfskKmyFwk39Xg8AC7exnp0CJOmDzQpyq5OqjUPhR6pKFtHYiTRWjDMrMGvd
         IMZcEwcKII1QxRI1i2UpTIhSPjwJzyqBVRpIDNM7QDu0InUpCc8cs7TernA1QtTfaS/m
         HpmBuB67sjN/b0rrV7XMr4AoMXqR6ptg3z3Rpgg9n0/1EfQZL+kzX1lh7VRhwnGe6Lur
         EVOnybgYrXDGlol0ba1Bx3xy1u2FGtC9GsbHJ03IvDiXAt3TLy+UB0KXNahxQE3wxkez
         recQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789732262; x=1790337062; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HR32eDowvoU7s9fv7SYXh2McaBai5hrd98uYm+h1guU=;
        b=UPHw0cBN+lLJEOyDVkaWSFgDp4QlM6/Xhzz5NbrszzzQAhLrruBlcSpX9xXkUloCWi
         SI0Grf0dzlWYXM0gVdI9tFYSssblbqqCfR5CU8HMco/OyBk7JOpo1o7Fa7eVatqczojj
         4sOHBdq0vFpaZZ4jPwwy45A/y/abY8K9DwDsXoACDjmiPi7LHDlJHL2drPLriFkiKTSB
         y698XMkoKxCCMuoGYtcU0OSPVjr6dp+cXskXuCK0A621dKlSyXnwpqMhqPz47HOkClac
         /RIHVwo5Qq7NizN7b/Gs1oEVAhhvthkLqwrSd5PzyRW6yrukR8sw9Trqx34OgqEGFmRV
         4Uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789732262; x=1790337062;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HR32eDowvoU7s9fv7SYXh2McaBai5hrd98uYm+h1guU=;
        b=0Nly485obN/TsYSSzJhol7rfv5C6FrNyVEoCbpbIqn63CXOKIF2s6MlROGsuHfqpY3
         Ulo4wGzP8WpdPJHyDJSRagO2MDu7t8CjH77PSw3iqMH7YyTYcBs9MSrcAbl9BjmBx+U0
         zUKeWqR9OItlWnkajd98IekdZs60bT6T4YNWKXHIeFsV7eb41fJqarhonn8I2Ba1ybfI
         0wj8MvXhRn9vrYpmVVBp3zH+tJuVqqleoQZlwmgKWvWP1uJHQTMo+B+5m3wn8OynVST9
         boYYBxY9N7gQxw8k+Jw3YCnzypAttaww9qioXHvIeC3ISh7Wk/AggTqfcYAsf84CQIbD
         XJrQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2O/rlHrMKtuF82ecXC6iUZBHYGvGr+m+1DZBZjEWnACDIPTwqAxubvTconHMJbU8V9bJchx8=@vger.kernel.org
X-Gm-Message-State: AFuF++mtPwvTeZtjz1cBPKcOEwgSOM+z3xhkFpG1Evu+exJOfmhX7l+8
	mrA6SnDaCw8TMx0NmQ317BZfd4ZK+T3CZ5hCfPlpBo3So0g9BB0edqZLtwhAYlROTstBhiJ1dmf
	+gDTrwVrF+fO6MbVH+vpI3YWnDgtSrB0=
X-Gm-Gg: AYBFou1bINXw00F0kQgoeJqchzQM4x1QcjlCd3jCoCjHBYKxUmJLvT/S+fCopjH0EQ+
	y2P+sIYxPBI5LJA3QxRSL/GhKE23TB5iRw7H5y2kBhKQ49vXnygOxay9HWvXwzNV6rJv9LHJvfN
	1aHy6K4F2pS3c/lf7Cwri0ETNEb3KCzNpUOPOWbWqadTU54CSh/aF43xsaVH63sHhcSli+dHoq6
	0e8dxRC+DxMla4w9KBLRDexPGBvZ0hFcu+Hm5cDMS+1957WFHGpcpP9vOOPg6DE6ZQWcxpZUIKZ
	BPhxvKUEgE2yH0xSpnMH4BsNRmSlfi5hLPeqoEkeGefovLZBSIsuXICEPUg=
X-Received: by 2002:a17:907:970d:b0:c24:4128:c19f with SMTP id
 a640c23a62f3a-c2a15699fdcmr247289066b.11.1789732261931; Fri, 18 Sep 2026
 04:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918040214.85580-1-ndaugoing@gmail.com> <20260918040214.85580-2-ndaugoing@gmail.com>
 <CA+EHjTx8zzvgqj99TKWfRD58X-M8v+hs9358_r_1zZonFNEsgw@mail.gmail.com>
In-Reply-To: <CA+EHjTx8zzvgqj99TKWfRD58X-M8v+hs9358_r_1zZonFNEsgw@mail.gmail.com>
From: Yuchao Zhang <ndaugoing@gmail.com>
Date: Fri, 18 Sep 2026 19:50:50 +0800
X-Gm-Features: AcwNN1Wto2_O0uy6UTTB6in3F4ALPKeKnrIKn4mv5wL6jmnw_dTYJHrXeQ1oo0Y
Message-ID: <CAC2BP3K-fvW2s2j2ys+kPMuxrzeMw9yc6MrAk7U7CqCpb2WePQ@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: arm64: vgic: Do not remove in-flight LPIs from AP
 list on disable
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fuad,

Thanks a lot for pointing me to that thread! I was not aware of
Hyunwoo's earlier report and the discussion with Oliver and Marc.

I'll read through the thread and their rationale on the ap_list_lock
approach. I'm happy to defer to Hyunwoo's effort to avoid duplicate
work.

Thanks again for the pointer!

Best regards,
Yuchao

Fuad Tabba <fuad.tabba@linux.dev> =E4=BA=8E2026=E5=B9=B49=E6=9C=8818=E6=97=
=A5=E5=91=A8=E4=BA=94 15:22=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Yuchao,
>
> On Fri, 18 Sep 2026 12:02:14 +0800, Yuchao Zhang <ndaugoing@gmail.com> wr=
ote:
>
> [...]
>
> > Note: this closes the primary race (the last_lr_irq node itself is no
> > longer unlinkable while in-flight), but the fold traversal can still
> > race with a remote flush unlinking a subsequent non-LR node in the
> > ap_list tail. Fully closing that window needs the fold side to take
> > references before dropping locks (in the spirit of the prune-side fix
> > in commit 7258770e5814 ("KVM: arm64: vgic: Handle race between
> > interrupt affinity change and LPI disabling")) and is left as a
> > follow-up.
>
> This is the same race Hyunwoo reported back in June [1]. You might
> want to have a look at that thread first: Oliver and Marc's view there
> was that the fix is to take the ap_list_lock in
> vgic_v3_fold_lr_state() [2][3], and Hyunwoo posted a draft of that
> [4].
>
> Cheers,
> /fuad
>
> [1] https://lore.kernel.org/r/aiHrGM1f8czcUby4@v4bel
> [2] https://lore.kernel.org/r/aiJi5a3JJ-TbWL-s@kernel.org
> [3] https://lore.kernel.org/r/87a4t99z9n.wl-maz@kernel.org
> [4] https://lore.kernel.org/r/aiXvwGD1hS6vwLEd@v4bel
