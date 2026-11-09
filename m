Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794253553;
	b=rUZSdsnEnWd83XKFputTr4RhSmnlB6lGqdIzQMos2/nutuEap0S1uyZ9I/I8LaRtJY6F
	 RALJKTVywBEQny6C6Yfprl1gaxmSku8T8J+elbSDyk4tcahIaHqh+YRJ1MT19HohBE61v
	 veVhfyS2+4MitZn5Y2XeVw4CARQ4P7G68/shUN3zenlyq6ZegnicXewPDn6DsGEzulyQ/
	 xfEaKBUs7k79vuw0rab1QNm+gTa29SnGCHu0BYrh2zrSv52veMXDhaNfXDbCaLjsNOqmR
	 F2ckdGR++fky04ypo88AZqJEYw9Gk2d37B/c+jCpFs1G9juT/mcODvAazFIr+nV0uaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253553;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eiGRyV0/2D+VxvRiL6LVlldu4Mo4SygtHqGmo4tg7R4=;
	b=bww0Zey/yAC4vdj4SNVenOKwSoiCccdEfk9ewWiySu2JA1rfynfYnm08G5vNiUj58pCk
	 21llPqaX51NElzMxxZuVxan5MwGycC8nbk6oK9YL2VxuecicczWA1/abbwTCsXa2d0Sum
	 AoJlt5K0cBRNS/bbcv9RwA4aUN0G52NH8omCOAZKUa7K6wGF5ZbqR8gTyh7cXLk+nPVML
	 CJcl4EBlREUCHyjTdm+wL6WlqF8+77zEPRoEfr/IGpJ9FiaEwfWg7cl5vKw+KP1vdzrY5
	 Twox8RgGkxHbOiaVJS9fi5lOmahlSalhUYHCP4rrRAD3ZAOWxd84ibIDn5/OzgJpfeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ercuwi9C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF737606A325
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 19:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF737606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ercuwi9C
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so9995ad.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 11:45:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794253552; cv=none;
        d=google.com; s=arc-20260327;
        b=R18zrGkW67yZmyANcMDyvq7AlCY0if0wc8j2+xfSWUTqS0nwlsK9F1ziLwIVPS/aKb
         XWqb1fJloYnGoJuIsUzxjP5bwNEt+JkmWReWcFJ5LgYB/nhRQ5ehLu9nPjcUOU05Y1Id
         s58D24cknAJM3ciCLiqXd9R8ingOk+dl3+/tSABT74G9RRQ04uMDaEvrZVbdvJbfNoAh
         QTLNbjz1uML1qajukqbLMNFPQbLkanoS/QkLVN4amZYVUI8jdXagu5xhjG7yDjvKhvSP
         wwNc1qIzGXby8SfXK2hxcwBSR+OvjkvdUc3C3AZgTi+nFxxXS6TCjZcY2pM3R+fLt4Le
         igOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eiGRyV0/2D+VxvRiL6LVlldu4Mo4SygtHqGmo4tg7R4=;
        fh=AMXxB4NPqNi6QoAFEyMV9Q/fGRmAZW1LgL3s7oTQRUU=;
        b=sJ6hhc+6UchK2OE/LXAm+XhEfv/aoqP5lyJeA1DIy6JzpX/OyhX6juWAN2iemqkcTR
         /egbtxgfCZNu9DqoEmsESL+ZT0O3UEm2ZXfiKvbXV3dId0lJV+gBOCIRMa2w+dPTMuCD
         /bFZATdwrKNy4KrXcXQTfPBzVQuvVn/Oa/1mhOkMJRc5VTDNhTuuD1Hdd3raMzkXfeWY
         ojSkTRj33+kANjSL/bhs5ge1RTBdXIAFixUJ5ozdqTg4jZgYEK3hAstHkt3YF/x5slOY
         JyHxjTBNDd4im9Vb5vPdrxLVXn/vW9jtlGT1U0X2r7pa0WVfLJsNBdamHD3I1ieB5tXi
         q3pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794253552; x=1794858352; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eiGRyV0/2D+VxvRiL6LVlldu4Mo4SygtHqGmo4tg7R4=;
        b=ercuwi9CYDzC+T4JGz/F0D3B+85z2Syi6RARIORqBqZuGpbJ/zyh7Jg7ftBxmI87m7
         V9LMsYyHH/UWGGm0BjUJvBOE9ZGwVYxTtu00M25zOLX13MW4eXH28pNAo1gxWRZVUkdr
         lj9BOW1uoh+Vliox898zW5pmTqaWmJV+7MCuQa8b2jfUCp4U4nzzaPPgQz5VWRF4SKzG
         seucLzuI4CoQ9dv0qjSZB5fi35fbmV0c0O4gIkbnM0uIozjbfOekgiqU4/vyKxZeRpJf
         /v4ub8l29DZ8IuUctZVr8i+WbJ8DbC/Eki25p7DDotPOQcKq1o532C71uKGcO8AR1sSk
         y94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253552; x=1794858352;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eiGRyV0/2D+VxvRiL6LVlldu4Mo4SygtHqGmo4tg7R4=;
        b=TxHmE8KrguAfeWA/pfEMMseOlGLqSiEiYoKSKLwVZB6bUKC4PgD8dlc4fIXgtRMCIt
         7NNMOc81aPSQfr+foYWOf20W/lHnhDGXQH85+IGk9iW2N/Vzgoc4ZZZe+qiWPkxLM0o3
         2R1QrufnqMesNs7rLb46eOzzh6nWNLJlJAWEQGWtGFJ5VasKHg0SbanW4ml2+YFig8ir
         ccoCKqwTznffVqsS5PfQC4fckYt8FZGqofIifPx+KcQNrGJVlcIzCx6NkPOfThJ5w3ow
         20TEtCwHZ/OGTI3cWuYVHG5t91zphDSfogTMv0Kuc5B4+AIyGvVA4h0VhIQaW49xF/TA
         +Zag==
X-Forwarded-Encrypted: i=1; AL+hErHILhoFv44X/Kwm7+oj3eA6SHoaZJzzkjMzjv73F2rML+s/2IgCiKP6MwcUzhBlOUVIHrfi5cs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+SVLa7eTppHn8MBgzuqHpWW+Ej6Lly98Q0Pi5aakoJDIutrb8C
	h+oeFBsidyQiMjc+ZljcIB3ij+h3vnPNbGMnRlmUvnuV7GafRw228yAATFDN+NjzOaHMjDl+qsp
	GmTHW2SNyyeifo4AXsUX7QQ5qMfOSnt+sy3+4LMAW5ab5Y37v0ThVLo2+jgiJtg==
X-Gm-Gg: AYBFou2EV+FcW4e80NLbHbaxvon6Czj0LhajaAyF3XowFbTCtesn3uq/n2defHTpYRu
	9WcPCt43PE3pg7G/aKAA05Bivc7Oecyy8s5k53LOR/tL9glVqay0++/9CirVrCTU+oWjmuaGXHl
	8l07TyyFaYVTF8eumdZdBU2jMtfai2Few/smNmOWLg5aTSrC/J8ari2YRfpfIUX5ZoeQsO3FiUv
	X8pceGjcezfXORZjwzwMpkPdsO48LuF8QqlPLRkK5jxIwud2WmicfAhpQLPEivEoPJmjsjkb6RR
	hqQfd1Ff4t7tLBn2WTC8acLMyui5sfoyo1AQXR9mHcMiFhM2q3Bm8aRlV7TgrP4j0N/sTw1AbTp
	buTF9N/TJeHlibgknNIaxPEoDadp7vhKX46ezBoN4u65z009BceYyJYImShCsFYd8msXlg8jQKo
	cHbxntbNx1wkOXiVSZcRRm7k27dBv8KBS1RSLJcD8=
X-Received: by 2002:a17:902:f611:b0:2e6:d25:d874 with SMTP id
 d9443c01a7336-2edb812e0bbmr796845ad.10.1794253551599; Mon, 09 Nov 2026
 11:45:51 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104070041.1902653-1-yhlee@isslab.korea.ac.kr>
In-Reply-To: <20261104070041.1902653-1-yhlee@isslab.korea.ac.kr>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Mon, 9 Nov 2026 11:45:40 -0800
X-Gm-Features: AclHuK_whYsAe78BgacGejquIYJ9dQ31ukLprOco_opsVCNz0hY1b_kOtAwu6a4
Message-ID: <CAEAWyHerrErox7nuZVau0T++ymEhF7jfo1rccxtOqyXKm--Kqg@mail.gmail.com>
Subject: Re: [PATCH net] gve: bound the device reported RSS sizes in the RSS query
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: Joshua Washington <joshwash@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Willem de Bruijn <willemb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Hariprasad Kelam <hkelam@marvell.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 11:01=E2=80=AFPM Yehyeong Lee <yhlee@isslab.korea.ac=
.kr> wrote:
>
> gve_adminq_process_rss_query() copies priv->rss_key_size bytes and
> priv->rss_lut_size words out of the admin queue buffer.  Both sizes come
> from the device: gve_parse_device_option() takes them from the RSS device
> option with no validation, and gve_adminq_describe_device() stores them.
> They are 16 bit fields, so either can be up to 65535.
>
> The source is one GVE_ADMINQ_BUFFER_SIZE block and the payload starts
> after the descriptor, so it holds at most 4088 bytes.  The only length
> test compares the sum with descriptor->total_length, which the same devic=
e
> wrote, and it is computed into a u16:
>
>         u16 hash_lut_length;
>         ...
>         hash_lut_length =3D priv->rss_lut_size * sizeof(*rxfh->indir);
>
>         if (sizeof(*descriptor) + priv->rss_key_size + hash_lut_length !=
=3D
>             total_memory_length) {
>
> A lut size of 16384 makes that product 65536, which truncates to zero, so
> the device only has to report a total_length of 48 to pass.  The loop the=
n
> reads 16384 words, 65536 bytes, out of a 4096 byte block, and the walk
> lands in rxfh->indir, which the ethtool core sized from the same device
> value.  ETHTOOL_GRSSH and ETHTOOL_GRXFHINDIR hand that to the caller and
> neither needs CAP_NET_ADMIN, net/ethtool/ioctl.c exempts them.
>
> Reject sizes that do not fit the buffer, and compute the lut length in a
> type that cannot truncate.
>
> In the driver the block is dma_pool memory, so KASAN does not annotate it
> and the contents of the neighbouring blocks leak with no report at all;
> the report below comes from a KUnit harness that hands the handler a
> kmalloc block of the same size, injects the device reply, and is not part
> of this patch.  Unpatched, a lut of 16384 and a lut of 1022 both read pas=
t
> the block; with the patch both are rejected with -EINVAL, and the sizes
> the driver itself defaults to, 40 and 128, still work.
>
>   BUG: KASAN: slab-out-of-bounds in gve_adminq_process_rss_query+0x3da/0x=
4a0
>   Read of size 4 at addr ffff888002845000 by task kunit_try_catch/54
>
>   CPU: 0 UID: 0 PID: 54 Comm: kunit_try_catch Tainted: G                 =
N  7.3.0-dirty #11 PREEMPT(lazy)
>   Tainted: [N]=3DTEST
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x3f/0x50
>    print_report+0xcd/0x620
>    ? gve_adminq_process_rss_query+0x3da/0x4a0
>    kasan_report+0xde/0x110
>    ? gve_adminq_process_rss_query+0x3da/0x4a0
>    gve_adminq_process_rss_query+0x3da/0x4a0
>    gve_rss_run.constprop.0+0xa7/0x1a0
>    ? __pfx_gve_rss_run.constprop.0+0x10/0x10
>    ? __pfx_read_tsc+0x10/0x10
>    ? ktime_get_ts64+0x192/0x250
>    kunit_try_run_case+0x1ca/0x4b0
>    ? __pfx_kunit_try_run_case+0x10/0x10
>    ? kthread_affine_node+0x247/0x360
>    ? __pfx_kthread_affine_node+0x10/0x10
>    ? __pfx_kunit_try_run_case+0x10/0x10
>    ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
>    kunit_generic_run_threadfn_adapter+0x7b/0xe0
>    kthread+0x36a/0x4f0
>    ? __pfx_kthread+0x10/0x10
>    ret_from_fork+0x34d/0x620
>    ? __pfx_ret_from_fork+0x10/0x10
>    ? __switch_to+0x22/0xde0
>    ? __pfx_kthread+0x10/0x10
>    ret_from_fork_asm+0x19/0x30
>    </TASK>
>
>   Allocated by task 54:
>    kasan_save_stack+0x33/0x60
>    kasan_save_track+0x14/0x30
>    __kasan_kmalloc+0x8f/0xa0
>    __kmalloc_noprof+0x19b/0x3e0
>    kunit_kmalloc_array+0x1b/0x50
>    gve_rss_ctx_init+0x40a/0x910
>    gve_rss_run.constprop.0+0x93/0x1a0
>    kunit_try_run_case+0x1ca/0x4b0
>    kunit_generic_run_threadfn_adapter+0x7b/0xe0
>    kthread+0x36a/0x4f0
>    ret_from_fork+0x34d/0x620
>    ret_from_fork_asm+0x19/0x30
>
>   The buggy address belongs to the object at ffff888002844000
>    which belongs to the cache kmalloc-4k of size 4096
>   The buggy address is located 0 bytes to the right of
>    allocated 4096-byte region [ffff888002844000, ffff888002845000)
>
>   The buggy address belongs to the physical page:
>   page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x28=
40
>   head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>   flags: 0x4000000000000040(head|zone=3D1)
>   page_type: f5(slab)
>   raw: 4000000000000040 ffff888001042140 dead000000000122 000000000000000=
0
>   raw: 0000000000000000 0000000000040004 00000000f5000000 000000000000000=
0
>   head: 4000000000000040 ffff888001042140 dead000000000122 00000000000000=
00
>   head: 0000000000000000 0000000000040004 00000000f5000000 00000000000000=
00
>   head: 4000000000000003 ffffea00000a1001 00000000ffffffff 00000000ffffff=
ff
>   head: 0000000000000000 0000000000000000 00000000ffffffff 00000000000000=
00
>   page dumped because: kasan: bad access detected
>
>   Memory state around the buggy address:
>    ffff888002844f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    ffff888002844f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   >ffff888002845000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                      ^
>    ffff888002845080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>    ffff888002845100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> Fixes: fa46c456fa6e ("gve: Add RSS adminq commands and ethtool support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

Similarly to https://lore.kernel.org/netdev/CAEAWyHdJNjhV4biOFR+cw0MWNMZHUT=
638+AT9Q83s9G7wyBsgw@mail.gmail.com/,
the driver already provides an 'available_length' field as part of
gve_adminq_query_rss_config(). So this should be dropped too.

> ---
>  drivers/net/ethernet/google/gve/gve_adminq.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> index 8b215fca9c1b63..1ba658cb2942be 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -1615,7 +1615,7 @@ static int gve_adminq_process_rss_query(struct gve_=
priv *priv,
>                                         struct ethtool_rxfh_param *rxfh)
>  {
>         u32 total_memory_length;
> -       u16 hash_lut_length;
> +       u32 hash_lut_length;
>         void *rss_info_addr;
>         __be32 *lut;
>         u16 i;
> @@ -1623,6 +1623,14 @@ static int gve_adminq_process_rss_query(struct gve=
_priv *priv,
>         total_memory_length =3D be32_to_cpu(descriptor->total_length);
>         hash_lut_length =3D priv->rss_lut_size * sizeof(*rxfh->indir);
>
> +       if (sizeof(*descriptor) + priv->rss_key_size + hash_lut_length >
> +           GVE_ADMINQ_BUFFER_SIZE) {
> +               dev_err(&priv->dev->dev,
> +                       "rss sizes from device do not fit the adminq buff=
er: key %u lut %u\n",
> +                       priv->rss_key_size, priv->rss_lut_size);
> +               return -EINVAL;
> +       }
> +
>         if (sizeof(*descriptor) + priv->rss_key_size + hash_lut_length !=
=3D total_memory_length) {
>                 dev_err(&priv->dev->dev,
>                         "rss query desc from device has invalid length pa=
rameter.\n");
>
> base-commit: 787268686c64be60023743b527645a907e38ccca
> --
> 2.43.0
>
