Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35AE44A3E2
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 12:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787918712; cv=none; b=lFznNmLywhzAjbEsZ700zawTflZqdL5Ss+r59+b+zFCd/S+H+HlkT9Yfa11AH9HYB1KRzsubP8aJuJzbVNoDKpPV5WHSBgyC+X3yC0Sj776eJg7yDHpqN9MZh3qp1mRv/ifCrd5UiAJYb+mZQr1zyZCIgecsfajxQUva6eTDlDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787918712; c=relaxed/simple;
	bh=g7/k4uisB3yiRQCJKrGol/lrSc+9m+nkgTGpTG9dJqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7HMR1U6hSTu0p+RLbXjpMLxCFblqN1cXTzGu3bpkYKaUDhRu0hD4iDpgI5M5S2Q0TaP47YqS0O3jXR7E3YClQjlvldAoyHvdwOy2XUVbDdxBJVA9IfHQhSMxyLrq2W6ZwwkJ0EglzGVBo+Qb76lIXeb+romsTj/NZQeIKQ8C/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xsgpn7Yt; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xsgpn7Yt"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7eb6573bd52so1030582a34.3
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 05:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787918689; x=1788523489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lWqQxoK7O394GAzySBcQeCr6jt4vv9YmvdIACmdtGGM=;
        b=Xsgpn7YtNYvW1F1t+i+s/PdkQ27wofqFDAPjvgqNsdY/+Jc/MUoI4D8X+zVj/3rR4u
         kjI2uNCqvK2HI1YYbTAwUyuEkJDXU5kX9cyyIHUpliA4ym8WAMdTi0qZll4c//piBoBd
         Cuq/4GoK/OA18D8D7E7eVgt7OHjXqwiTyL+QxGexhIZ51eSDCbrosszVNzol67MibKmy
         X6e81LpnDCdYZZb8MESf/Cm9i/GR2VEsI/Ty9Rmmm/Q9Db2ig+x2fouec7W7hdwUCZF7
         YUwPsyvWVZdusOF354K0S2wyhzUNgG3s3y2Si+1YMMT6WdSVE7B4xjRLOUH60cYJRNPl
         QPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787918689; x=1788523489;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lWqQxoK7O394GAzySBcQeCr6jt4vv9YmvdIACmdtGGM=;
        b=oXLzyQHWAbYr++4f9uiG1efZNckk/PqC54behO+/8HweY0nMXSWgoD2PpjPryEGCXS
         +eZECOPzxsRywi6xHfaxP158s6F0PNcJQlT37XZ20L/nPGzq/bi+HWowf6AoaFgXcPMM
         rRpZLZSgPbJ1disHsGrWQUUwuVzEd3/oDcExyu4N6AK9wParGagwyTtl2Z7Nxq9+iAKx
         89VCvQ+JkDmPyd1a2W7A6cDX27CHr52zU1BxnkwwLTsmsFhu7SS1hOVKmKJzNgpd9uHP
         qOdaCYX76ZmVjgDu4nnEVWNnBr2GYPCftsSbtU5AuPH02knYi46A5yyLPOwkjhcwi3sU
         eQug==
X-Forwarded-Encrypted: i=1; AHgh+RqMULtIfNY/oMFqaFNCMeZZGNAJw+4mA1VfNjm7fTtGb/fE6+l1ivSpdYzYaOlgRfAuESc8zuQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l62HAQ1s+tCk0ZHM4496CtzLiBKfWKjJsWmfVvBf9nO3tx2mgt
	Q52G0Iz41I8tBGkjLmSYFuw2l5nwKl24Cg+5nj+3Fy9pFv9VnffWhM6B
X-Gm-Gg: AR+sD13V6SLvu1CNhfz5Ww4vuih10a6JxQt3uPBsEFaEKf1OBHIZMpUVG4jAEWcxH/A
	yaY9gJ84VYL5ON0P/xCxVNtq34Lwd2tTyoD7h4CPpXjuy4vzKbGPjHXDuTOt6xudSHyLE8qixz+
	+INCSrMTmhBUGCYjVMGXKujapvdGegwFlR5hha5J2+9lOykjRIwl7w9e1wGSsz71FOaAX7igaA3
	d4eR1EyH1PhpCh4LTPCyLcqrg/2zeOHiDMaNMeXzvXZXdzBbxYxDUthJtTki/mn+sNEBRustTDR
	Q04VRpJ/GD6HwBR+/CAq4uhjIhBHuKC89dxG1gRpyGt+vbg8NAHANEI1XKCLiJ6YuwJ8XbInq5N
	VkdmBA9j0IhG/PvD8uA4Uaqq3ifpYKyGszpg5eEry3r1q9d4S+NwkTAxydkzWGecFUxyz4fjpGm
	geiEF2e7a9KL5t6HnyPzsdzFXx/DeYtTXkDPGVSzQ0OzSQmS+AG00bDQPp7R5owa5xnWjo+rNDX
	9Jl0bzhRHZ0Kq+qHVkxMEp8wwCqwg==
X-Received: by 2002:a4a:e7c8:0:b0:6ac:8e23:3078 with SMTP id 006d021491bc7-6b1c6422a9bmr4115615eaf.5.1787918689511;
        Fri, 28 Aug 2026 05:04:49 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:590d:7e37:c87d:136d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f8095bcsm5559760eec.12.2026.08.28.05.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 05:04:48 -0700 (PDT)
Date: Fri, 28 Aug 2026 05:04:45 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Alexei Turtanov <9alexei9@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Input: atkbd - skip deactivate for Xiaomi Redmi Book Pro
 16 2026
Message-ID: <apF5WFQU9LPM2lYL@google.com>
References: <20260828112239.18081-1-9alexei9@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828112239.18081-1-9alexei9@gmail.com>

On Fri, Aug 28, 2026 at 02:22:39PM +0300, Alexei Turtanov wrote:
> The internal keyboard of the Xiaomi Redmi Book Pro 16 2026 (board TM2425)
> does not work: atkbd_probe() succeeds and every command is ACKed, but no
> scancodes ever arrive afterwards.
> 
> Testing on the hardware through serio_raw shows that ATKBD_CMD_RESET_DIS
> (0xF5) is the culprit. After 0xF5 the embedded controller keeps ACKing
> commands but stops delivering scancodes, and neither ATKBD_CMD_ENABLE
> (0xF4) nor ATKBD_CMD_RESET_BAT (0xFF) bring them back. Only re-enabling
> the keyboard interface at the controller level (i8042 command 0xAE, or
> rewriting the command byte as i8042_port_close() does) revives it.
> Running the init sequence without 0xF5 (0xED 0x00, 0xF3 0x00, 0xF4)
> keeps the keyboard working.
> 
> 'i8042.dumbkbd=1' also works around this, but then the driver never
> writes to the keyboard and the LEDs cannot be controlled. Use the
> existing atkbd_deactivate_fixup quirk instead, as done for the sibling
> TM2424 by commit 3a046db33bb9 ("Input: atkbd - skip deactivate for
> Xiaomi Book Pro 14's internal keyboard"). Tested on v7.2: keyboard,
> Caps Lock LED and s2idle suspend/resume all work.
> 
> DMI: XIAOMI REDMI Book Pro 16 2026/TM2425, BIOS RMAPT6B0P0909 05/22/2026
> 
> Fixes: 9cf6e24c9fbf ("Input: atkbd - do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexei Turtanov <9alexei9@gmail.com>

Applied, thank you.

-- 
Dmitry
