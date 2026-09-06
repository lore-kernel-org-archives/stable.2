Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DC73F20FA
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 11:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788695533; cv=none; b=rKBpmCo5VmB6LscfCQzrWfSkeTgsZy2OSjwxy2MsXNFHOYkHfrVOhDB0zbBjrdsJChOQwVOHFFT650nZJ2QpdGz451tMExJDqQUn8cmB/ollAaASfqnBWGhMaAC08XVV4XHUSN7k+VshP57arRY2ir0KXQ7C6VGfSYewiRFh1AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788695533; c=relaxed/simple;
	bh=4a+b4l1RWP15Ux4UpGRplfTzKsv0JlvAp60nX2qV23g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iuvFVYhxlnKvReWgSMc6a9uh0Ax1ELrWBUheIH12UcuxRKZ7Up4mbYFa3DmbLQeCIVT9QbKZUkWv9q5TTb1ma6hsm8JwFLF9KolwnLZo8r1gLTVxwOEW4ZYUl7EPwSyb0WxJrVMzQcx6tmWqIFDZKYd8m6npoeZGsgzdaFQudvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EVa+peeb; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EVa+peeb"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4858595f997so1433543f8f.1
        for <stable@vger.kernel.org>; Sun, 06 Sep 2026 04:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788695528; x=1789300328; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Um0jmnCjFD+GeY+0sjcM/sT/JhzCslZHTdSmFe/0w4Y=;
        b=EVa+peeb5Z7s1uovncgWchyFNifIkmhsuIUXU9uTbgNw+n/btetOJdMVrpKKUzAGF4
         vW+Bb9ELh2SAgQlaucKLDqSqwQR66cRgEJoWmX7rM2p/ciIvEQgp7n8gPNY0mrnst2sa
         AITj7VTS/7urCesVE5JOdNN/CQw4oIR+u20+yRkg+QYTQKdWTQXqmXN7wFepjSXQxj+i
         rjsN8T3xhYK3eLlLyk6ZaG6F+V4D925NCTAhAGeBHqTkAWKD77aqcBxQg1asjLUYKZDO
         ysmrd3A4Eymysu2E6VKynt8tPMnp0wlXbyG6lfo1oZYGuZZP52spdmONllrLrUA8v0GK
         r44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788695528; x=1789300328;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Um0jmnCjFD+GeY+0sjcM/sT/JhzCslZHTdSmFe/0w4Y=;
        b=YbIGSZy/a7IsrpQZ1YP0tewHoUJVyGw0mtet2gDeAFxgluM72HNDaK1s69j+UxAWxl
         OUv5WwTtb3Vf9F+caMbjma5An7O+0P656xdJcIg8TPiNFVpAWKL99Xq2sYHZbBRijqfw
         BQRKWPf53KEkU5sCwu5uMFCQbueIq6FcsNSzGG8YLRWOZ431IviAuXm547fcD4xAufNP
         0cXX6cwJCYh5QRts+0cr/FsWEt2GwBthGLPQVjdULmDUTV04EDDI+kAmA6oe5W0C4xs/
         oP0BWpWDf8AJ09xwLF6F3xOXCEp3ckY1ng39B08DDo6e9PDa/9Nzi6Jb9aZRab4qBwlg
         ek+A==
X-Forwarded-Encrypted: i=1; AKwUvByL5lGv+HjL3RYwUgMzTylKb8VVfQMpThW+YLZkK5yliix4fgtVH+Dq9aduz520wNR2Lyk/GLA=@vger.kernel.org
X-Gm-Message-State: AFuF++kix4Z33IBLwl8oYAC3UjgZXAlBE9ezOhdxgwab4diZ7qQKacXV
	tqNG2mZSdy36H/peWj8Oxr9vzFaJYr1dwj+qbrFOdZ99t8CQvutzQFtvS3AUHp2WDoI=
X-Gm-Gg: AYBFou0JhIPzGgOJmkACiEx2IaMlYrEnnVI/mNFxdeGxslSPUuT6CMAOKJFTI5R/hlE
	pSShtNI+OLKtNlk23plTddpOzis9HY0O3kK17s71YLr8Cni2NnNXx4RQnfcBCXPGO0N6+VP0w1k
	UO6spUi9bVzir6NQAx6JWW5MWNx7e1CmXD8qLKNtmMN2k0PooSptbQapQbnoZg65NgDrFD14AMA
	vFlpMHNyW5BMe+opqxEh5u6d4xLAj8cMoYINr0I7jLFsM5XXMYNlTwcKfzygAHRLxYA/DxsGrg+
	Zg0Ch8iPrHGLg9LIDE/yi9yrhGtl3BkeOvW+j+m+K7gkHBz6xTI5Kc+cz7mOQrsDQvGjS+s+vZo
	4G2FMBW5K2UFaQgEp1L+y8rvjGyRh12yZYDQhTjytT1Q4fMcLwg/nixC4ka/7zzqF7M5j1ZPpxV
	MqAyUTJ9OquDlRcRg7gfYIxmRQWDX7vjc83HTsPIx4sXZC1oDxgWA6+erQzvyFIH/M7MNRgPNo+
	A==
X-Received: by 2002:a05:6000:707:b0:485:8542:fee3 with SMTP id ffacd0b85a97d-4858708cab5mr37301319f8f.16.1788695527540;
        Sun, 06 Sep 2026 04:52:07 -0700 (PDT)
Received: from [192.168.0.35] ([109.76.250.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858d2693e8sm19337821f8f.3.2026.09.06.04.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 04:52:07 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v16 0/5] Add phy_get_by_of_node and devm helper
Date: Sun, 06 Sep 2026 12:52:01 +0100
Message-Id: <20260906-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v16-0-f7bd68b5369f@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/53TzUrEMBAA4FeRno3M5D+efA/xkN/dgrbSrqWy7
 Ls7XZBWcoqXQCbkm2GGuXZznvo8d88P127KSz/340AX1I8PXTz74ZRZnyjQceAKBAoWJHvvh6+
 VDXm9MK4YCEbhdJl7tmK2gAAs+o95ZqhAFyNDSMJ3BH5OufTrPdvrG93P/XwZp+978kVt0X+lW
 eiRWamj81o64e0L/fTT+DROp27Ls+ijLZtsTXZOMfBYokDOK9vstkFssg3ZEKJK3vKiuK5s+2t
 r4ES12JZspxQa4USg8ivbHW3dZDuyvXJRFBAmQahshB0X2IYj9YSVVLKzkg6JtY4HvbF0mhAwF
 ZyQqELWKdU633UDtk3nW+1WWZu8xIL1RFEcdN6oi63v2SJmXsA4V+ty1x20LRHtBXUec8EccwK
 jal0d9bY1wm1HtQ3Goc7Gi/JHv91uPxyHzUSKBAAA
X-Change-ID: 20250313-b4-linux-next-25-03-13-dtsi-x1e80100-camss-1506f74bbd3a
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>, 
 Todor Tomov <todor.too@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Bryan O'Donoghue <bod@kernel.org>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Felipe Balbi <balbi@ti.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-phy@lists.infradead.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org, 
 Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13119;
 i=bryan.odonoghue@linaro.org; h=from:subject:message-id;
 bh=4a+b4l1RWP15Ux4UpGRplfTzKsv0JlvAp60nX2qV23g=;
 b=owEBbQKS/ZANAwAKASJxO7Ohjcg6AcsmYgBqnVPj9lo7XLf1CSvgqCIyrt+WqIwZt4dxhcAys
 mPhQDGMbYyJAjMEAAEKAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCap1T4wAKCRAicTuzoY3I
 OnsMD/9qD+Zs6QIr1Doj1PM5z9fmopYR1GYlaPIYa0K5SS0JJSeeOgZ+r+ga62X7dhmY5bYZ/3W
 gxZqrsGizuUXsM48ohj/ioVCIQuzbT6PqF62RVDvfJotKcwM79wnFEtO5gv8yPI2H5tO4de3T64
 aSjvr+fFHfVoF0p97gHpZvYPifBR56ynNPoyMwXSiCifkp36+eB6yx77dqlTS+vaYwcwPoTIuRu
 MIou6eShE6RbB0VCQzqih76VxvPHpnqNs0SzhM4+yWGHQLuUxq+21TO8XR3aFIsRwPfrZ+eNDC4
 jLtVGm3nS/oTUP0D94zcnfb0o5w4P38ik6Q+eFipPGrTVnmWC7kvIel1Z8gKH45E6pWk7JY5c08
 +4g29xp3ydmSHpV/LSB3n5fm3cG+b/6RISAu9LhSmdo0OzFz1ne2TvEF2l0Bkfs6iTjC0w7KdvQ
 rOL8WSzmCV0wNvn6x3m71vf4I+Rpzjjmt0mx0bHtaDJlxBO9MbrMb0Lq7N8sohuqXIhXGV2N6wp
 lD02VeXpsi8P0QVAvpRz4LFA1F0D8ogcNWEnWrJKRYhN35cYQqULRHJKQx4Yi4VXEW6suSDZS+D
 0hU5T3DSkr1XpmPMdvRHduTHUfXqwOhe3PEAFB1MR92HUIJkvU50gF5emXdKBlDThUZwW3+5qod
 GZn/WmyYtRZaFVw==
X-Developer-Key: i=bryan.odonoghue@linaro.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

This series has evolved from a CAMSS standalone series to a series that is
mostly on the PHY side now, so I've split the series up to reflect that
fact.

Starting off by fixing a long-standing use-after-free race-condition in the
phy core flagged by Sashiko in v13. While my series doesn't introduce the
bug it seems appropriate to address it anyway once flagged.

Once addressed two new helper functions are introduced to the PHY core to
enable finding of a PHY using the media graph.

Finally the usage of that new API is shown with CAMSS.

Changes in v16:
- Changes CAMSS CSID to enable lanes based on indexing starting at 1.
  Since the new patch depends on the antecedent patch bundling in this series - Nihal
- Depends-on: https://lore.kernel.org/r/20260903-x1e-csi2-phy-v17-0-26606fa9a039@linaro.org
- Link to v15: https://patch.msgid.link/20260904-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v15-0-68b7916e7a3f@linaro.org

Changes in v15:
- Adds lockdep_assert - Loic 
- Depends-on: https://lore.kernel.org/r/20260903-x1e-csi2-phy-v17-0-26606fa9a039@linaro.org
- Link to v14: https://patch.msgid.link/20260903-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v14-0-01ef1eced075@linaro.org

Changes in v14:
- Fixes existing bug highlited by Sashiko in v13.
  The bug has appropriate Fixes: tags applied for back-porting.
- RB accumulated from v13 for the now standalone CAMSS patch.
- YAML changes carried thus far will instead be posted with dtsi changes
  where they 'feel' more logical.
- Depends-on: https://lore.kernel.org/r/20260903-x1e-csi2-phy-v17-0-26606fa9a039@linaro.org
- Link to v13: https://patch.msgid.link/20260728-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v13-0-ae811e2f0799@linaro.org

Changes in v13:
- Introduces struct device_node phy helper lookup.
  This allows for finding a phy from a device_node entry.
- Uses media-graph exclusively to reference phys. - Neil, Vlad, Vinod
- Performs runtime check for legacy v non-legacy phys - Krzysztof
- Link to v12: https://patch.msgid.link/20260708-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v12-0-f8588da41f16@linaro.org

Changes in v12:
- Updates camss sensor find method to find the sensor in the CSIPHY port. -
  Neil, Vlad, Bryan
- Drops dependency on passing polarities and positions. Moved into CSIPHY
  port as agreed. Neil, Vlad, Bryan
- Omitted mux to CSID as discussed this will be done when splitting CSID
  out as its own individual node. Neil, Bryan
- Updated Reviewed-by: - Loic
- Link to v11: https://lore.kernel.org/r/20260326-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v11-0-5b93415be6dd@linaro.org

Changes in v11:
- Dropped simple-mfd in dts for devm_of_platform_populate() - Krzysztof
- Pass polarity and position for data and clock lanes - bod
- Remove check for PHY_TYPE_DPHY - PHY driver validates its own mode - bod
- Depends-on: https://lore.kernel.org/r/20260325-dphy-params-extension-v1-0-c6df5599284a@linaro.org
- Depends-on: https://lore.kernel.org/r/20260326-x1e-csi2-phy-v5-0-0c0fc7f5c01b@linaro.org
- Link to v10: https://lore.kernel.org/r/20260316-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v10-0-fdfe984fe941@linaro.org

Changes in v10:
- compat simple-mfd added to CAMSS allows probing sub-nodes.
  The other way to do this would be simple-bus however, CAMSS
  is really a collection of devices in a block as opposed to a
  discoverable bus.
- csiphy nodes are sub-nodes of CAMSS.
  Sub-nodes as pointed out by Dmitry will allow us to show some love to
  older platforms.
- Depends-on: https://lore.kernel.org/r/20260315-x1e-csi2-phy-v4-0-90c09203888d@linaro.org
- Link to v9: https://lore.kernel.org/r/20260226-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v9-0-a59c3f037d0b@linaro.org

v9:
- Adds phy handles as optional nodes
- Adds minItems: 5 for iommu entries
  I believe this should be acceptable as maxItems: 8 continues
  to be valid
- Makes CAMSS-level rails optional for x1e
  Similarly I think this should be OK as the legacy binding
  is still valid it is simply optional instead of mandatory now
- Supports CSIPHY nodes adjacent to CAMSS while leaving
  csiphy regs intact.
- Pushes dtsi drop to another series everything in this series
  can go through linux-media
- Depends-on: https://lore.kernel.org/r/20260226-x1e-csi2-phy-v3-0-11e608759410@linaro.org
- Link to v8: https://lore.kernel.org/r/20260225-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v8-0-95517393bcb2@linaro.org

v8:

- This version rebases on latest media-committers/next - bod
- Adds support for "combo-mode" PHYs in the YAML.
  It will be possible to build out the code to support this later - Vlad
- Maintains the upstream model of connecting sensors to CSI decoders.
  Every other upstream implementation does it this way so
  CAMSS will do it this way too.
- Reduces the number of IOMMU entires in CAMSS to those required for
  CSID, VFE/RDI/PIX respectively.
  Including all of the IOMMUs implies we will also "stuff" CAMSS
  with ever increasing lists of registers but a better approach
  is to have individual nodes for functional blocks.
  For example this series supports CSIPHy as a separate block
  CCI is already a separate block - and we will add ICP, BPS, IPE
  etc as additional standalone nodes.
  camss@someaddr {
        //existing bindings vfe, csid, csiphy go here
        iommus = <just what's needed for this>;
  };
  bps@some_other_address {
        iommus = <bps specific iommus>;
  }
  In particular this model will save us from going down the same
  path as the vpu which has ended up tripping over the total size
  an iommu entry may span.

  Nobody really likes the legacy binding much so instead of
  continuing to bludgeon more entries into it, I've conciously
  not included BPS, IPE, ICP etc.

Depends-on: https://lore.kernel.org/r/20260225-x1e-csi2-phy-v2-0-7756edb67ea9@linaro.org
Link to v7: https://lore.kernel.org/r/20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-0-0bc5da82f526@linaro.org
Working tree: https://gitlab.com/Linaro/arm64-laptops/linux/-/tree/qcom-laptops-v6.19-rc8-camss?ref_type=heads

v7:

- Reimagine the PHYs as individual nodes.
  A v1 of the schmea and driver for the CSI PHY has been published with
  some review feedback from Rob Herring and Konrad Dybcio

  https://lore.kernel.org/r/20250710-x1e-csi2-phy-v1-0-74acbb5b162b@linaro.org

  Both the clock name changes from Rob and OPP changes suggested by Konrad
  are _not_ yet present in this submission however stipulating to those
  changes, I think publishing this v7 of the CAMSS/DT changes is warranted.

  Its important to publish a whole view of changes for reviewers without
  necessarily munging everything together in one sprawling series.

  TL;DR I moved the PHY driver to its own series review comments there
  are not reflected here yet but "shouldn't" have a big impact here.

- Having separate nodes in the DT for the PHYS allows for switching on PHYs
  as we do for just about every other PHYs.
  &csiphyX {
      status = "okay";
  };

  We just list phys = <> in the core dtsi and enable the PHYs we want in
  the platform dts.

- The level of code change in CAMSS itself turns out to be quite small.
  Adding the PHY structure to the CSIPHY device
  Differentiating the existing camss.c -> camss-csiphy.c init functions
  A few new function pointers to facilitate parallel support of legacy
  and new PHY interfaces.

- A key goal of this updated series is both to introduce a new PHY method
  to CAMSS but to do it _only_ for a new SoC while taking care to ensure
  that legacy CAMSS-PHY and legacy DT ABI continues to work.

  This is a key point coming from the DT people which I've slowly imbibed
  and hopefully succeeded in implementing.

- In addition to the CRD both T14s and Slim7x are supported.
  I have the Inspirion14 working and the XPS but since we haven't landed
  the Inspirion upstream yet, I've chosen to hold off on the XPS too.

- There is another proposal on the list to make PHY devices as sub-devices

  I believe having those separate like most of our other PHYs
  is the more appropriate way to go.

  Similarly there is less code change to the CAMSS driver with this change.

  Finally I believe we should contine to have endpoints go from the sensor
  to CAMSS not the PHY as CAMSS' CSI decoder is the consumer of the data
  not the PHY.

- Working tree: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/x1e80100-6.16-rcX-dell-inspiron14-camss-ov02c10-ov02e10-audio-iris-phy-v3
- Link to v6: https://lore.kernel.org/r/20250314-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v6-0-edcb2cfc3122@linaro.org

v6:
- Removes 'A phandle to an OPP node describing' per Krzysztof's comment
  on patch #1
- Drops Fixes: from patch #1 - Krzysztof
- The ordering of opp description MXC and MMXC is kept as it matches the
  power-domain ordering - Krzysztof/bod
- Link to v5: https://lore.kernel.org/r/20250313-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v5-0-846c9a6493a8@linaro.org

v5:
- Picks up a Fixes: that is a valid precursor for this series - Vlad
- Applies RB from Vlad
- Drops "cam" prefix in interconnect names - Krzysztof/Vlad
- Amends sorting of regs, clocks consistent with recent 8550 - Depeng/Vlad
- Link to v4: https://lore.kernel.org/r/20250119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v4-0-c2964504131c@linaro.org

v4:
- Applies RB from Konrad
- Adds the second CCI I2C bus to CCI commit log description.
  I previously considered leaving out the always on pins but, decided
  to include them in the end and forgot to align the commit log.
- Alphabetises the camcc.h included in the dtsi. - Vlad
- Link to v3: https://lore.kernel.org/r/20250102-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v3-0-cb66d55d20cc@linaro.org

v3:
- Fixes ordering of headers in dtsi - Vlad
- Changes camcc to always on - Vlad
- Applies RB as indicated - Krzysztof, Konrad
- Link to v2: https://lore.kernel.org/r/20241227-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v2-0-06fdd5a7d5bb@linaro.org

v2:

I've gone through each comment and implemented each suggestion since IMO
they were all good/correct comments.

Detail:

- Moves x1e80100 camcc to its own yaml - Krzysztof
- csid_wrapper comes first because it is the most relevant
  register set - configuring all CSID blocks subordinate to it - bod, Krzysztof
- Fixes missing commit log - Krz
- Updates to latest format established @ sc7280 - bod
- Includes CSID lite which I forgot to add @ v1 - Konrad, bod
- Replaces static ICC parameters with defines - Konrad
- Drops newlines between x and x-name - Konrad
- Drops redundant iommu extents - Konrad
- Leaves CAMERA_AHB_CLK as-is - Kronrad, Dmitry
  Link: https://lore.kernel.org/r/3f1a960f-062e-4c29-ae7d-126192f35a8b@oss.qualcomm.com
- Interrupt EDGE_RISING - Vladimir
- Implements suggested regulator names pending refactor to PHY API - Vladimir
- Drop slow_ahb_src clock - Vladimir

Link to v1:
https://lore.kernel.org/r/20241119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v1-0-54075d75f654@linaro.org

Working tree:
https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/arm-laptop/wip/x1e80100-6.13-rc3

v1:

This series adds dt-bindings and dtsi for CAMSS on x1e80100.

The primary difference between x1e80100 and other platforms is a new VFE
and CSID pair at version 680.

Some minor driver churn will be required to support outside of the new VFE
and CSID blocks but nothing too major.

The CAMCC in this silicon requires two, not one power-domain requiring
either this fix I've proposed here or something similar:

https://lore.kernel.org/linux-arm-msm/bad60452-41b3-42fb-acba-5b7226226d2d@linaro.org/T/#t

That doesn't gate adoption of the binding description though.

A working tree in progress can be found here:
https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/x1e80100-6.12-rc7+camss?ref_type=heads

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
Bryan O'Donoghue (5):
      phy: core: Fix use-after-free in phy_get paths
      phy: core: Add phy_get_by_of_node()
      phy: core: Add devm_phy_get_by_of_node()
      media: qcom: camss: Add support for PHY API devices
      media: qcom: camss: Use data-lanes starting at 1 for new CSIPHY mode

 drivers/media/platform/qcom/camss/Kconfig        |   1 +
 drivers/media/platform/qcom/camss/camss-csiphy.c | 177 +++++++++++++++++++++--
 drivers/media/platform/qcom/camss/camss-csiphy.h |  11 +-
 drivers/media/platform/qcom/camss/camss.c        | 119 +++++++++++++--
 drivers/media/platform/qcom/camss/camss.h        |   1 +
 drivers/phy/phy-core.c                           | 172 +++++++++++++++++-----
 include/linux/phy/phy.h                          |  13 ++
 7 files changed, 423 insertions(+), 71 deletions(-)
---
base-commit: 2e41fb778334db3d260c52c6be4c4d44fbed87ac
change-id: 20250313-b4-linux-next-25-03-13-dtsi-x1e80100-camss-1506f74bbd3a

Best regards,
--  
Bryan O'Donoghue <bryan.odonoghue@linaro.org>

