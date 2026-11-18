Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794996238;
	b=jPN9t2PniMQowe6wr0tm22HSccJ8QaljnxNHgBLrFNGqzarSj9867vME0656+uGU52Go
	 /hSwt3yYhDWP57Rw2eVn4Q7JIfusHnAthdjdl9kWzvGhtVWqqehWvaiKp28Zvba6JzW25
	 s5ABP/MBNCmFtQSOtGYdtAb+u8/713pt8szHymopyQy3Z2McGSmpkOV60Vw5xxqnOXFRA
	 socUGl6OXvpjXLJsEPPBDvzWBK4gv/csEGgDR/0y682gaGTha27D3S81fqD476lNWFcnG
	 dT6XQfLZBJNStWQsddN8aB830a2ODMSHmeuk9cstP4EtAffZR1zLscxnrbYLfa3qwKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=j+Y2FiNk9Wl9qy2Tngasbxd4q3UxkbbYUIzjyrrCkFc=;
	b=k+wcp/Jd/aE0V1fs9N3/7siIZl7wn8kjmEFVoR7zkOPKITPekSYDFoOfR7JqEJDLM727
	 BnfiVgmvGDkR9OJQcr/d9mrotRaFd/rIxIUV6sd5fNS5A4ATLJ7PotDLOK3FrpnEihYtB
	 lqUMWj+Rkli4x1n08SV+K+67SljfirqJoZXHTrJIjCj0nEZ9KZcGRaroaEZMdWKVYBTPX
	 ofBkhwkKuZMy3UOpvhBtkPLDD54Ynrg+RdgNsN81bIkD1Fngx3FhlkC02NlkoGePNKBNX
	 ZLTZMHAE6uxdxv5lDCf5M+acdzJ69SMZum4sgJWYcQZFN0/kNn8BrhYlRW2aXs3B17g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="PjwvOV/H";
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40085606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 10:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40085606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PjwvOV/H
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4b467581b98so9050375e9.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 02:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794996237; x=1795601037; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j+Y2FiNk9Wl9qy2Tngasbxd4q3UxkbbYUIzjyrrCkFc=;
        b=PjwvOV/HB9EDAmJ0beGEqqeUTsLrkVZhdcux9SGuDKjQHS5B4RUgDr661ySi2v2Kwk
         gHvkIN6DsB80jYxUljZo6dl+OHc7Bsijpy5mbgqi31+5esopKrJ9HGYR4/xtWRUuWJMn
         i/lJBKM/QepPOrMeoJ6UHC9k3KwvliFRGGYZnElTKH+gcnv+bAqTExxdEI9K5vkmu+np
         lK/Iud4Vv2i3MnVNbPx4bQLeyUNbKclzrHyxf3mu4an7rsI9VMokDAMqdoGgJaTpqKbM
         xyo0J9JgVQNVADkNzzm5GXe5vWZXo0UVgkyNwzNO+NOFpkDgRMgrAtFpy01JTQ+G3M7j
         0Xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794996237; x=1795601037;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j+Y2FiNk9Wl9qy2Tngasbxd4q3UxkbbYUIzjyrrCkFc=;
        b=OFq+osyoQBXQV9F1QAxbER1oIc+52P6LXm9+QRuLJJ9EHe54qYfJ1nblgQRuyoag7J
         MuWP+yRzSv8qPyK2Z6Dks93WyaHxT7UOjoMz8lpunBH39p2cuAHCrbXFOvwGifhG9xQC
         ej/wW6FbAIVuICrEMqrmuqxTa1uweQ84xL3i72ItTJzensgu7G0D9bSNACkgx2HtiQTm
         ynGL1f1BgwOx9oS/TZ9WLoaANV6qHd4u0Fq0jpUrtGCf3ktZKJzLspfqLTgMCcorbVnw
         R6hnv06AzZcVyEOSIxI4B2tOEysm9ThIWiTrDMdsiE6pfxbGdk+CtYZ8RpcfIU/bynFv
         3XkQ==
X-Forwarded-Encrypted: i=1; AL+hErHyKVlbVuXtokdGuqtDZwqRCM82DVr/Uj/zyMwYd0HqUqmQ9yWXjDgcB3+ND62OkWNwt4LyR08=@vger.kernel.org
X-Gm-Message-State: APuU4Z9D29Y/M3/mKTyzvs5HE7F8sZJo2vLrBfRSoo+QsEB9h4NOPiv+
	U0ggZGR/P2DBhFx8oVqtjXvamHHhr0x05ebSXLKVd1+OI/sFyqhpgDSO
X-Gm-Gg: AYBFou1vbwkRE6DfcwSXsKIpfQNvf0AL//oELdNZPJDuLM7VZLyfgXBpxWciWK1OPul
	frFUgCsYZpUd4UZLf709zWZ3WRGKOk84LbSZBW0NCQq6xDczgucq9T6FOCt1fW4T1ELVQ+jDq9h
	69O+yM/sJW7TiilwdvY9x6N68gP8+o+Tsxcm4D9hIrGR7OL2G16qGa7aPFOO96RtKi6LdWUylYA
	Tyyr/Evb+Txcho96Ti56rEaCua45hBZRnVB6k0pVCjQYytN1j+BzekI/77hSZ30gT1okwEtTWbW
	PmBomtwSL7PxL5Yd1MbuFqIGfzg97XeJoGiyvUPQLUfXdG+aC82ur4qFN4Nj1tuGL6005ARsgVF
	ClJikDLqC7oUFw+tGKMrGHmxQbs6gJBkdPgS1lYw2PJFxJcmYHKE+jq2p4DDDTSJQGaHSZfL4QF
	PLNiicKDfwPn+xHTLuOrIujQ9ylOx9Jq0icmHDrB9T+nj6yWgrI5tRtkA1l/opnK7O6mz9HPRX1
	3AUzkgGic9t4kDphNJpCJ3AlRZvjXxaTLTABx98+I+EjCBn19fXoSoI1/+vOY1DjVK3VWs8jA0/
	4GAgNku4bV2YmRzK6dzsGgtL5T7aP/kFDdgIfZc4ts460b/oK6drEes0Mq2skdJ+2Q==
X-Received: by 2002:a05:600c:800f:b0:4bb:5bf3:8ee9 with SMTP id 5b1f17b1804b1-4bb7da4ec63mr37351435e9.31.1794996236390;
        Wed, 18 Nov 2026 02:03:56 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783f7eecsm242389095e9.3.2026.11.18.02.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:03:55 -0800 (PST)
Date: Wed, 18 Nov 2026 10:03:54 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Nathan Chancellor
 <nathan@kernel.org>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2] sched/topology: Avoid unsequenced accesses to
 jiffies in sd_init()
Message-ID: <20261118100354.495fda73@pumpkin>
In-Reply-To: <CAKwvOd=9pjhCnreMvoAH_0PegYg60ouaZL=BAjB242bE48J23g@mail.gmail.com>
References: <20261116-topology-wunsequenced-v2-1-54611119172b@kernel.org>
	<20261117183043.GK1813469@noisy.programming.kicks-ass.net>
	<CAKwvOd=9pjhCnreMvoAH_0PegYg60ouaZL=BAjB242bE48J23g@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Nov 2026 10:39:15 -0800
Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Tue, Nov 17, 2026 at 10:30=E2=80=AFAM Peter Zijlstra <peterz@infradead=
.org> wrote:
> >
> > I don't speak enough C legal to actually understand the Changelog, but
> > the actual change seems daft. Is this really needed? =20

A better description might be saying something about ensuring the two
jiffies values are the same.
As coded they can be different with either larger.

> I would imagine a delta of the disassembly here before/after the
> change would make it more obvious (one less volatile access, which be
> have arbitrary ordering between initializing other members).
>=20
> But I guess I'm also curious why jiffies is defined as volatile
> anyway? I thought the usual guidance was to use
> cast-to-volatile-qualified pointer during access, rather than declare
> as volatile?

I'm sure that guidance was based on the fact that not all accesses needed
to be volatile.
But now the tools are getting picky and needing WRITE_ONCE() as well as
READ_ONCE() and bleating about plain accesses maybe it is less relevant.
So if all access have to be volatile why not make the variable volatile?

Doesn't this initialiser also generate 'really crap code'?
IIRC it is likely to generate an on-stack structure and then do a memcpy().

David
